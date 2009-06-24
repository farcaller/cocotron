PROJECT(Foundation)

CMAKE_MINIMUM_REQUIRED(VERSION 2.4)

FUNCTION(FIND_STUFF dir ext plat var)
	# find all files with EXT in DIR matching specified PLATform and return
	# the list in VAR
	
	FILE(GLOB files "${dir}/*.${ext}" "${dir}/**/*.${ext}")
	FOREACH(f ${files})
		# check each file
		GET_FILENAME_COMPONENT(fn ${f} NAME)
		STRING(REGEX MATCH ".*/platform_([a-zA-Z0-9]+)/.*" m ${f})
		IF(NOT ${m} STREQUAL "")
			# platform_ source
			STRING(REGEX MATCH ".*/platform_${plat}.*" m ${f})
			IF(NOT ${m} STREQUAL "")
				# good match: platform_PLAT
				SET(fl ${fl} ${f})
			ELSE(NOT ${m} STREQUAL "")
				STRING(REGEX MATCH ".*/platform_posix/.*" m ${f})
				IF(NOT ${m} STREQUAL "")
					# good match: platform_posix
					SET(fl ${fl} ${f})
				ENDIF(NOT ${m} STREQUAL "")
			ENDIF(NOT ${m} STREQUAL "")
		ELSE(NOT ${m} STREQUAL "")
			# good match: non-platform
			SET(fl ${fl} ${f})
		ENDIF(NOT ${m} STREQUAL "")
	ENDFOREACH(f)
	SET(${var} ${fl} PARENT_SCOPE)
ENDFUNCTION(FIND_STUFF)

FUNCTION(DETECT_COCTRON_PLATFORM)
	IF(${CMAKE_SYSTEM_NAME} STREQUAL "Darwin")
		SET(COCOTRON_PLATFORM "darwin")
	ELSEIF(${CMAKE_SYSTEM_NAME} STREQUAL "OpenBSD")
		SET(COCOTRON_PLATFORM "bsd")
	ENDIF(${CMAKE_SYSTEM_NAME} STREQUAL "Darwin")
	SET(COCOTRON_PLATFORM ${COCOTRON_PLATFORM} PARENT_SCOPE)
	MESSAGE("Platform ${CMAKE_SYSTEM_NAME} was detected as ${COCOTRON_PLATFORM}")
ENDFUNCTION(DETECT_COCTRON_PLATFORM)

DETECT_COCTRON_PLATFORM()

SET(ASM_SRC
	objc/objc_msgSend-darwin-i386.s
)

FOREACH(src ${ASM_SRC})
	GET_FILENAME_COMPONENT(FILE_BASE ${src} NAME_WE)
	SET(SRC ${CMAKE_CURRENT_SOURCE_DIR}/${src})
	SET(OBJ ${CMAKE_CURRENT_BINARY_DIR}/${FILE_BASE}.o)
	ADD_CUSTOM_COMMAND(
		OUTPUT ${OBJ}
		MAIN_DEPENDENCY ${SRC}
		COMMAND gcc ARGS -c ${SRC} -o ${OBJ}
	)
	SET(ASM_OBJS ${ASM_OBJS} ${OBJ})
ENDFOREACH(src)

FIND_STUFF(${CMAKE_SOURCE_DIR} "h" ${COCOTRON_PLATFORM} foundation_headers)
FOREACH(src ${foundation_headers})
	GET_FILENAME_COMPONENT(file_base ${src} NAME)
	SET(dst "${CMAKE_BINARY_DIR}/headers/Foundation/${file_base}")
	ADD_CUSTOM_COMMAND(
		OUTPUT ${dst}
		COMMAND ${CMAKE_COMMAND} ARGS -E copy ${src} ${dst}
		DEPENDS ${src}
		VERBATIM
	)
	SET(foundation_headers_inst ${foundation_headers_inst} ${dst})
ENDFOREACH(src)

ADD_CUSTOM_TARGET(Foundation_headers DEPENDS ${foundation_headers_inst})

INCLUDE_DIRECTORIES(BEFORE
	"${CMAKE_BINARY_DIR}/headers/"
)

ADD_DEFINITIONS(-D__LITTLE_ENDIAN__ -march=i686)

FIND_STUFF(${CMAKE_SOURCE_DIR} "m" ${COCOTRON_PLATFORM} foundation_sources)
ADD_LIBRARY(Foundation SHARED ${foundation_sources} ${ASM_OBJS})
ADD_DEPENDENCIES(Foundation Foundation_headers)
