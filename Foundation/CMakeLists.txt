PROJECT(Foundation)

CMAKE_MINIMUM_REQUIRED(VERSION 2.4)

# first target is to gather all headers into one convient place
ADD_CUSTOM_TARGET(Foundation_Headers)
FILE(GLOB Foundation_HEADERS *.h **/*.h)
FOREACH(SRC ${Foundation_HEADERS})
	GET_FILENAME_COMPONENT(FILE_BASE ${SRC} NAME)
	SET(DST "${CMAKE_BINARY_DIR}/headers/Foundation/${FILE_BASE}")
	ADD_CUSTOM_COMMAND(
		TARGET Foundation_Headers
		POST_BUILD
		COMMAND ${CMAKE_COMMAND} ARGS -E copy ${SRC} ${DST}
	)
	SET(Foundation_HEADERS_INST ${Foundation_HEADERS_INST} ${DST})
ENDFOREACH(SRC)

# and objc headers too
ADD_CUSTOM_TARGET(OBJC_Headers)
FILE(GLOB OBJC_HEADERS "${CMAKE_SOURCE_DIR}/../objc/*.h")
FOREACH(SRC ${OBJC_HEADERS})
	GET_FILENAME_COMPONENT(FILE_BASE ${SRC} NAME)
	SET(DST "${CMAKE_BINARY_DIR}/headers/objc/${FILE_BASE}")
	ADD_CUSTOM_COMMAND(
		TARGET OBJC_Headers
		POST_BUILD
		COMMAND ${CMAKE_COMMAND} ARGS -E copy ${SRC} ${DST}
	)
	SET(OBJC_HEADERS_INST ${OBJC_HEADERS_INST} ${DST})
ENDFOREACH(SRC)

# now we need headers from Foundation_Headers and from OBJC_Headers
INCLUDE_DIRECTORIES(BEFORE
	"${CMAKE_BINARY_DIR}/headers/"
)

# FIXME: this should be added elsewere
ADD_DEFINITIONS(-D__LITTLE_ENDIAN__ -march=i686)

# Now all the Foundation sources
SET(Foundation_SRC
	objc/ObjCArray.m
	objc/ObjCClass.m
	objc/ObjCDynamicModule.m
	objc/ObjCException.m
	objc/ObjCHashTable.m
	objc/ObjCModule.m
	objc/ObjCSelector.m
	objc/Object.m
	objc/ObjectiveC.m
	objc/Protocol.m
	objc/objc-class.m
	objc/objc.m
	objc/objc_debugHelpers.m
	objc/objc_functions.m
	objc/objc_msg_lookup.m
	objc/objc_size_alignment.m
	
	NSAffineTransform.m
	NSArchiver.m
	NSAssertionHandler.m
	NSBundle.m
	NSByteOrder.m
	NSClassDescription.m
	NSCoder.m
	NSConcreteDirectoryEnumerator.m
	NSDebug.m
	NSDirectoryEnumerator.m
	NSDistributedLock.m
	NSDistributedNotificationCenter.m
	NSEnumerator.m
	NSError.m
	NSFileManager.m
	NSFormatter.m
	NSGeometry.m
	NSHashTable.m
	NSHost.m
	NSIndexPath.m
	NSInvocation.m
	NSLocale.m
	NSMapTable.m
	NSMethodSignature.m
	NSNull.m
	NSNumberFormatter.m
	NSObjCRuntime.m
	NSPipe.m
	NSPlatform.m
	NSProcessInfo.m
	NSProxy.m
	NSRange.m
	NSSortDescriptor.m
	NSTask.m
	NSUnarchiver.m
	
	NSArray/NSArray_concrete.m
	NSArray/NSEnumerator_array.m
	NSArray/NSArray_placeholder.m
	NSArray/NSEnumerator_arrayReverse.m
	NSArray/NSMutableArray_concrete.m
	NSArray/NSArray.m
	NSArray/NSMutableArray.m
	
	NSAttributedString/NSRangeEntries.m
	NSAttributedString/NSMutableString_proxyToMutableAttributedString.m
	NSAttributedString/NSAttributedString_nilAttributes.m
	NSAttributedString/NSAttributedString.m
	NSAttributedString/NSAttributedString_manyAttributes.m
	NSAttributedString/NSAttributedString_placeholder.m
	NSAttributedString/NSAttributedString_oneAttribute.m
	NSAttributedString/NSMutableAttributedString_concrete.m
	NSAttributedString/NSMutableAttributedString.m
	
	NSAutoreleasePool/NSAutoreleasePool.m
	
	NSCharacterSet/NSCharacterSet.m
	NSCharacterSet/NSCharacterSet_rangeInverted.m
	NSCharacterSet/NSCharacterSet_range.m
	NSCharacterSet/NSMutableCharacterSet.m
	NSCharacterSet/NSCharacterSet_string.m
	NSCharacterSet/NSCharacterSet_bitmap.m
	NSCharacterSet/NSMutableCharacterSet_bitmap.m
	
	NSData/NSData.m
	NSData/NSMutableData_concrete.m
	NSData/NSData_mapped.m
	NSData/NSData_concrete.m
	NSData/NSMutableData.m
	
	NSDate/NSDate.m
	NSDate/NSCalendar.m
	NSDate/NSDate_timeInterval.m
	NSDate/NSDateFormatter.m
	NSDate/NSCalendarDate.m
	NSDate/NSDateComponents.m
	
	NSDictionary/NSDictionary.m
	NSDictionary/NSMutableDictionary.m
	NSDictionary/NSDictionary_mapTable.m
	NSDictionary/NSMutableDictionary_mapTable.m
	NSDictionary/NSEnumerator_dictionaryObjects.m
	NSDictionary/NSEnumerator_dictionaryKeys.m
	
	NSException/NSException.m
	NSException/NSRaise.m
	
	NSKeyedArchiving/NSKeyedArchiver.m
	NSKeyedArchiving/NSKeyedUnarchiver.m

	NSKeyValueCoding/NSArray+KVC.m
	NSKeyValueCoding/NSDictionary+KVC.m
	NSKeyValueCoding/NSKVCMutableArray.m
	NSKeyValueCoding/NSKeyValueCoding.m
	NSKeyValueCoding/NSKeyValueObserving.m
	NSKeyValueCoding/NSString+KVCAdditions.m
	
	NSLock/NSRecursiveLock.m
	NSLock/NSLock.m
	NSLock/NSSynchronization.m
	NSLock/NSConditionLock.m
	
	NSNotification/NSNotification_concrete.m
	NSNotification/NSNotification.m
	
	NSNotificationCenter/NSNotificationObserver.m
	NSNotificationCenter/NSNotificationCenter.m
	NSNotificationCenter/NSObjectToObservers.m
	
	NSNotificationQueue/NSNotificationAndModes.m
	NSNotificationQueue/NSNotificationQueue.m
	
	NSNumber/NSNumber_float.m
	NSNumber/NSNumber_unsignedLongLong.m
	NSNumber/NSNumber_unsignedChar.m
	NSNumber/NSNumber_placeholder.m
	NSNumber/NSNumber_BOOL.m
	NSNumber/NSNumber_unsignedLong.m
	NSNumber/NSNumber_unsignedShort.m
	NSNumber/NSNumber_longLong.m
	NSNumber/NSNumber_unsignedInt.m
	NSNumber/NSNumber_double.m
	NSNumber/NSNumber_char.m
	NSNumber/NSNumber_short.m
	NSNumber/NSNumber_int.m
	NSNumber/NSNumber.m
	NSNumber/NSNumber_long.m
	
	NSObject/NSObject.m
	NSObject/NSZombieObject.m
	
	NSPropertyList/NSPropertyList.m
	NSPropertyList/NSPropertyListWriter_xml1.m
	NSPropertyList/NSOldXMLReader.m
	NSPropertyList/NSPropertyListReader_vintage.m
	NSPropertyList/NSPropertyListReader.m
	NSPropertyList/NSOldXMLAttribute.m
	NSPropertyList/NSOldXMLDocument.m
	NSPropertyList/NSPropertyListReader_binary1.m
	NSPropertyList/NSPropertyListWriter_vintage.m
	NSPropertyList/NSOldXMLElement.m
	NSPropertyList/NSPropertyListReader_xml1.m
	
	NSRunLoop/NSRunLoopState.m
	NSRunLoop/NSOrderedPerform.m
	NSRunLoop/NSInputSourceSet.m
	NSRunLoop/NSInputSource.m
	NSRunLoop/NSRunLoop.m
	NSRunLoop/NSDelayedPerform.m
	
	NSSet/NSEnumerator_set.m
	NSSet/NSSet_concrete.m
	NSSet/NSSet_placeholder.m
	NSSet/NSMutableSet.m
	NSSet/NSCountedSet.m
	NSSet/NSSet.m
	NSSet/NSMutableSet_concrete.m
	NSSet/NSInlineSetTable.m
	
	NSStream/NSSocket.m
	NSStream/NSOutputStream_socket.m
	NSStream/NSOutputStream.m
	NSStream/NSFileHandle_stream.m
	NSStream/NSInputStream.m
	NSStream/NSSelectInputSource.m
	NSStream/NSSelectInputSourceSet.m
	NSStream/NSInputStream_data.m
	NSStream/NSInputStream_file.m
	NSStream/NSOutputStream_data.m
	NSStream/NSOutputStream_file.m
	NSStream/NSSelectSet.m
	NSStream/NSOutputStream_buffer.m
	NSStream/NSInputStream_socket.m
	NSStream/NSFileHandle.m
	NSStream/NSStream.m
	
	NSString/NSString_cString.m
	NSString/NSUnicodeCaseMapping.m
	NSString/unibuffer.m
	NSString/NSStringUTF8.m
	NSString/NSPathUtilities.m
	NSString/NSString_placeholder.m
	NSString/NSMutableString_unicodePtr.m
	NSString/NSString_nextstepCString.m
	NSString/NSMutableString.m
	NSString/NSString_unicodePtr.m
	NSString/NSString_unicode.m
	NSString/NSStringFileIO.m
	NSString/NSString_isoLatin1.m
	NSString/NSString_nextstep.m
	NSString/NSStringFormatter.m
	NSString/NSStringSymbol.m
	NSString/NSString.m
	NSString/NSConstantString-Impl.m
	
	NSStringsFileFormat/NSStringsFileParser.m
	
	NSScanner/NSScanner.m
	NSScanner/NSScanner_concrete.m
	
	NSTimer/NSTimer_concrete.m
	NSTimer/NSTimer.m
	NSTimer/NSTimer_invocation.m
	NSTimer/NSTimer_targetAction.m
	
	NSTimeZone/NSTimeZoneTransition.m
	NSTimeZone/NSTimeZone.m
	NSTimeZone/NSTimeZoneType.m
	NSTimeZone/NSTimeZone_absolute.m
	NSTimeZone/NSTimeZone_concrete.m
	
	NSThread/NSThread.m
	
	NSUserDefaults/NSPersistantDomain.m
	NSUserDefaults/NSUserDefaults.m
	
	NSValue/NSValue_pointer.m
	NSValue/NSValue_placeholder.m
	NSValue/NSValue_nonRetainedObject.m
	NSValue/NSValue.m
	NSValue/NSValue_concrete.m
	
	NSZone/NSZone.m
	NSZone/NSVirtualMemory.m
)

# POSIX-specific sources
SET(POSIX_SRC
	platform_posix/NSPlatform_posix.m
	#platform_posix/NSSelectSet_bsd.m
	platform_posix/NSPersistantDomain_posix.m
	platform_posix/NSLock_posix.m
	platform_posix/NSFileHandle_posix.m
	platform_posix/NSTask_posix.m
	platform_posix/NSFileManager_posix.m
	platform_posix/NSMemoryFunctions_posix.m
	platform_posix/NSSocket_bsd.m
	platform_posix/NSPipe_posix.m
	platform_posix/NSConstantString.m
)

# Linux-specific sources
SET(Linux_SRC
	platform_linux/NSMemoryFunctions_linux.m
	platform_linux/NSPlatform_linux.m
	platform_linux/NSTask_linux.m
)

# Linux-specific assembly
SET(ASM_SRC
	objc/platform_linux/objc_msg_sendv.s
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

# Build the Foundation library
ADD_LIBRARY(Foundation SHARED ${Foundation_SRC} ${POSIX_SRC} ${Linux_SRC}
	${ASM_OBJS})

# Hack to link with asm sources
TARGET_LINK_LIBRARIES(Foundation gcc)

# Foundation depends on its headers
ADD_DEPENDENCIES(Foundation Foundation_Headers OBJC_Headers)

# Installation rules
INSTALL(FILES ${Foundation_HEADERS_INST} DESTINATION "include/Foundation")
INSTALL(FILES ${OBJC_HEADERS_INST} DESTINATION "include/objc")
INSTALL(TARGETS Foundation DESTINATION lib)
