/* Copyright (c) 2006 Christopher J. W. Lloyd

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE. */

#import <AppKit/NSTextFieldCell.h>

@class NSButtonCell;

@interface NSComboBoxCell : NSTextFieldCell {
   id              _dataSource;
   NSSize          _intercellSpacing;
   float           _itemHeight;
   int             _numberOfVisibleItems;

   BOOL            _usesDataSource;
   BOOL            _hasVerticalScroller;
   BOOL            _completes;

   NSMutableArray *_objectValues;
   NSButtonCell   *_buttonCell;
}

-(void)addItemWithObjectValue:(id)object;
-(void)addItemsWithObjectValues:(NSArray *)objects;
-(void)removeAllItems;
-(int)indexOfItemWithObjectValue:(id)object;

-(void)insertItemWithObjectValue:(id)object atIndex:(int)index;

-(void)scrollItemAtIndexToVisible:(int)index;

-(void)selectItemAtIndex:(int)index;

-(BOOL)completes;
-(void)setCompletes:(BOOL)flag;

-(NSString *)completedString:(NSString *)string;

@end

@interface NSObject(NSComboBoxCell_dataSource)
-(NSString *)comboBoxCell:(NSComboBoxCell *)cell completedString:(NSString *)string;
@end
