//
//  SwiftForUnityBridge.m
//  JuniperPlugin
//
//  Created by Malaika Penn on 3/13/20.
//  Copyright © 2020 Malaika Penn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <ExternalAccessory/ExternalAccessory.h>
#include "JuniperPlugin-Swift.h"
#include "UnityInterface.h"
#pragma mark - C interface

extern void UnitySendMessage(const char *, const char *, const char *);
extern "C" {
     void _setupAccessoryList() {
          [[SwiftForUnity shared]       setupAccessoryList];
     }
}
extern "C" {
     BOOL _isAccessory() {
          return [[SwiftForUnity shared]       isAccessory];
     }
}
extern "C" {
     void _connect() {
          [[SwiftForUnity shared]       connect];
     }
}
extern "C" {
     void _disconnect() {
          [[SwiftForUnity shared]       disconnect];
     }
}
char* cStringCopy(const char* string){
     if (string == NULL){
          return NULL;
     }
     char* res = (char*)malloc(strlen(string)+1);
     strcpy(res, string);
     return res;
}
