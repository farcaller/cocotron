/* Copyright (c) 2006-2007 Christopher J. W. Lloyd

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE. */

// Original - Christopher Lloyd <cjwl@objc.net>
#import <AppKit/NSNibLoading.h>
#import <AppKit/NSNib.h>
#import <Foundation/NSString.h>
#import <Foundation/NSDictionary.h>
#import <AppKit/NSRaise.h>

@implementation NSObject(NSNibLoading)

-(void)awakeFromNib {
   // do nothing
}

@end
@implementation NSBundle(NSNibLoading)

+(BOOL)loadNibFile:(NSString *)path externalNameTable:(NSDictionary *)nameTable withZone:(NSZone *)zone {
   NSNib *nib=[[[NSNib allocWithZone:zone] initWithContentsOfFile:path] autorelease];
   
   return [nib instantiateNibWithExternalNameTable:nameTable];
}

+(BOOL)loadNibNamed:(NSString *)name owner:owner {
   NSDictionary *nameTable=[NSDictionary dictionaryWithObject:owner forKey:NSNibOwner];
   NSBundle     *bundle=[NSBundle bundleForClass:[owner class]];
   NSString     *path;

   path=[bundle pathForResource:name ofType:@"nib"];
   if(path==nil)
    path=[[NSBundle mainBundle] pathForResource:name ofType:@"nib"];

   if(path==nil)
    return NO;

   return [NSBundle loadNibFile:path externalNameTable:nameTable withZone:NULL];
}

-(BOOL)loadNibFile:(NSString *)path externalNameTable:(NSDictionary *)nameTable withZone:(NSZone *)zone {
   NSNib *nib=[[[NSNib allocWithZone:zone] initWithContentsOfFile:path] autorelease];
   
   return [nib instantiateNibWithExternalNameTable:nameTable];
}

@end

