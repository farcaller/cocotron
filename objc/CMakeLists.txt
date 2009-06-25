HEADER_RULE("objc" "objc_headers_inst")
ADD_CUSTOM_TARGET(ObjC_Headers DEPENDS ${objc_headers_inst})

INSTALL(FILES ${objc_headers_inst} DESTINATION "include/objc")
