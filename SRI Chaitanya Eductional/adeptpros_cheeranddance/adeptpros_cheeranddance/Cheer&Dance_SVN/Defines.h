//
//  Defines.h
//  eMenu
//
//  Created by Vijay  on 29/09/11.
//  Copyright 2011 Vijay. All rights reserved.
//


#ifdef UAT
#define kREAL_API_Endpoint_Host                 @"http://joomerang.geniusport.com/seetuat/"
#endif

#ifdef DEV
#define kREAL_API_Endpoint_Host                 @"http://joomerang.geniusport.com/landrover/"
#endif

//#define  BASEURL @"http://54.191.2.63/spiritcentral_uat/webservices_dev/"

#define  BASEURL @"http://54.191.2.63/spiritcentral/webservices_dev/"

//#define  BASEURL @"http://joomerang.geniusport.com/cheerinfinity/webservices_prod/"
//#define  BASEURL @"http://joomerang.geniusport.com/cheerinfinity/webservices_dev/"




//#ifdef PRODUCTION
//#define kREAL_API_Endpoint_Host                 @"http://REALService.rpclearning.com/"
//#define HOST                                    @"REALService.rpclearning.com"
//
//#elif STAGING
//#define kREAL_API_Endpoint_Host                 @"http://realstgservice.rpclearning.com/"
//#define HOST                                    @"realstgservice.rpclearning.com"
//
//#elif UAT
//#define kREAL_API_Endpoint_Host                 @"http://belauatservice.rpcsys.hmco.com"
//#define HOST                                    @"belauatservice.rpcsys.hmco.com"
//
//#elif QA
//#define kREAL_API_Endpoint_Host                 @"http://belaqaservice.rpcsys.hmco.com"
//#define HOST                                    @"belaqaservice.rpcsys.hmco.com"
//
//#else
//#define kREAL_API_Endpoint_Host                 @"http://belandservice.rpcsys.hmco.com"
//#define HOST                                    @"belandservice.rpcsys.hmco.com"
//#endif

//Login Header and base URL parameters...
//#define  BASEURL                       (kREAL_API_Endpoint_Host)
//#define GET_USER_SERVICE                        (kREAL_API_Endpoint_Host @"/User/GetUser")


//#define BASEURL @"http://joomerang.geniusport.com"
//#define BASEURLNEW @"http://www.geniusmenu.com"
//#define BASEPHOTO @"http://geniusmenu.com/Photos"

#define REQUEST_WEBSERVICE_DISPLAYMENU 11

#define REQUEST_WEBSERVICE_DISPLAYMENU_FOR_ID 12

#define REQUEST_WEBSERVICE_DISPLAYMENU_FOR_ID_1 13

