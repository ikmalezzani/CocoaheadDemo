//
//  Vector.h
//  Cocoahead
//
//  Created by Ikmal Ezzani on 10/17/15.
//  Copyright © 2015 Mindvalley. All rights reserved.
//

#ifndef Vector_h
#define Vector_h

CG_INLINE CGPoint
__CGPointAddition(CGPoint point1, CGPoint point2) {
    return CGPointMake(point1.x + point2.x, point1.y + point2.y);
}
#define CGPointAddition(point1, point2) __CGPointAddition(point1, point2)

#endif /* Vector_h */
