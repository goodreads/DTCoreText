//
//  UIFont+DTCoreText.m
//  DTCoreText
//
//  Created by Oliver Drobnik on 11.12.12.
//  Copyright (c) 2012 Drobnik.com. All rights reserved.
//

#import "UIFont+DTCoreText.h"

@implementation UIFont (DTCoreText)

+ (UIFont *)fontWithCTFont:(CTFontRef)ctFont
{
	NSString *fontName = (__bridge_transfer NSString *)CTFontCopyName(ctFont, kCTFontPostScriptNameKey);

	CGFloat fontSize = CTFontGetSize(ctFont);
	CTFontDescriptorRef ref = CTFontCopyFontDescriptor(ctFont);
	UIFont *font = CFBridgingRelease(CTFontCreateWithFontDescriptor(ref, fontSize, nil));

	// fix for missing HelveticaNeue-Italic font in iOS 7.0.x
	if (!font && [fontName isEqualToString:@"HelveticaNeue-Italic"])
	{
		NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    [attributes setObject:@"HelveticaNeue-LightItalic" forKey:(id)kCTFontFamilyNameAttribute];
    [attributes setObject:[NSNumber numberWithFloat:fontSize] forKey:(id)kCTFontSizeAttribute];
    CTFontDescriptorRef fontDesc = CTFontDescriptorCreateWithAttributes((CFDictionaryRef)attributes);
		font = CFBridgingRelease(CTFontCreateWithFontDescriptor(fontDesc, fontSize, NULL));
	}

	return font;
}

@end
