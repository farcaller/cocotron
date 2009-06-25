
# per-platform asm files
IF(${COCOTRON_PLATFORM} STREQUAL "darwin")
	SET(foundation_asm_src
		objc/platform_darwin/objc_msgSend-darwin-i386.s)
ELSEIF(${COCOTRON_PLATFORM} STREQUAL "win32")
	SET(foundation_asm_src
		objc/platform_win32/objc-msgsend.s
		NSObject/platform_win32/msgSendv-windows.s)
	ADD_DEFINITIONS(-DWINDOWS) # XXX: test
ELSEIF(${COCOTRON_PLATFORM} STREQUAL "linux")
	SET(foundation_asm_src
		objc/platform_linux/objc-msgsend.s
		NSObject/platform_linux/msgSendv-linux.s)
	ADD_DEFINITIONS(-DLINUX) # XXX: test
ENDIF(${COCOTRON_PLATFORM} STREQUAL "darwin")

ASM_RULE("${foundation_asm_src}" "foundation_asm_objs")
HEADER_RULE("Foundation" "foundation_headers_inst")
ADD_CUSTOM_TARGET(Foundation_Headers DEPENDS ${foundation_headers_inst})

INCLUDE_DIRECTORIES(BEFORE "${CMAKE_BINARY_DIR}/headers/")

ADD_DEFINITIONS(-D__LITTLE_ENDIAN__ -march=i686)

FIND_STUFF("${CMAKE_SOURCE_DIR}/Foundation" "m" ${COCOTRON_PLATFORM} foundation_sources)

ADD_LIBRARY(Foundation SHARED ${foundation_sources} ${foundation_asm_objs})
ADD_DEPENDENCIES(Foundation Foundation_Headers ObjC_Headers)

INSTALL(FILES ${foundation_headers_inst} DESTINATION "include/Foundation")
INSTALL(TARGETS Foundation DESTINATION lib)