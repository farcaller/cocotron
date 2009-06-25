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
				IF(NOT ${COCOTRON_PLATFORM} STREQUAL "win32")
					# if we're not targeting win32, we need platform_posix too
					STRING(REGEX MATCH ".*/platform_posix/.*" m ${f})
					IF(NOT ${m} STREQUAL "")
						# good match: platform_posix
						SET(fl ${fl} ${f})
					ENDIF(NOT ${m} STREQUAL "")
				ENDIF(NOT ${COCOTRON_PLATFORM} STREQUAL "win32")
			ENDIF(NOT ${m} STREQUAL "")
		ELSE(NOT ${m} STREQUAL "")
			# good match: non-platform
			SET(fl ${fl} ${f})
		ENDIF(NOT ${m} STREQUAL "")
	ENDFOREACH(f)
	SET(${var} ${fl} PARENT_SCOPE)
ENDFUNCTION(FIND_STUFF)

FUNCTION(HEADER_TARGET dir tn)
	FIND_STUFF("${CMAKE_SOURCE_DIR}/${dir}" "h" ${COCOTRON_PLATFORM} headers)
	FOREACH(src ${headers})
		GET_FILENAME_COMPONENT(file_base ${src} NAME)
		SET(dst "${CMAKE_BINARY_DIR}/headers/${dir}/${file_base}")
		ADD_CUSTOM_COMMAND(
			OUTPUT ${dst}
			COMMAND ${CMAKE_COMMAND} ARGS -E copy ${src} ${dst}
			DEPENDS ${src}
			VERBATIM
		)
		SET(headers_out ${headers_out} ${dst})
	ENDFOREACH(src)
	ADD_CUSTOM_TARGET(${tn} DEPENDS ${headers_out})
	#SET(${ovar} ${headers_out} PARENT_SCOPE)
ENDFUNCTION(HEADER_TARGET)

FUNCTION(ASM_RULE src ovar)
	FOREACH(f ${src})
		GET_FILENAME_COMPONENT(file_base ${f} NAME_WE)
		SET(src ${CMAKE_CURRENT_SOURCE_DIR}/${src})
		SET(obj ${CMAKE_CURRENT_BINARY_DIR}/${file_base}.o)
		ADD_CUSTOM_COMMAND(
			OUTPUT ${obj}
			MAIN_DEPENDENCY ${src}
			COMMAND ${CMAKE_C_COMPILER} ARGS -c ${src} -o ${obj}
		)
		SET(out ${out} ${obj})
	ENDFOREACH(f)
	SET(${ovar} ${out} PARENT_SCOPE)
ENDFUNCTION(ASM_RULE)
