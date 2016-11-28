/*
 * Convert.xc
 *
 *  Created on: Nov 28, 2016
 *      Author: Saša Ritan
 *		Contact: sritan@synapticon.com
 */

/*
 *       Copyright (c) Nov 28, 2016, Synapticon GmbH
 *       All rights reserved.
 *
 *       Redistribution and use in source and binary forms, with or without
 *       modification, are permitted provided that the following conditions are met:
 *
 *       1. Redistributions of source code must retain the above copyright notice, this
 *          list of conditions and the following disclaimer.
 *       2. Redistributions in binary form must reproduce the above copyright notice,
 *          this list of conditions and the following disclaimer in the documentation
 *          and/or other materials provided with the distribution.
 *       3. Execution of this software or parts of it exclusively takes place on hardware
 *          produced by Synapticon GmbH.
 *
 *       THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 *       ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 *       WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 *       DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
 *       ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 *       (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 *       LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 *       ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 *       (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 *       SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 *       The views and conclusions contained in the software and documentation are those
 *       of the authors and should not be interpreted as representing official policies,
 *       either expressed or implied, of the Synapticon GmbH.
 */

#include <FixedPoints.h>
#define Q 16

void FixedToFromFloating_representation()
{
    int16_t x = -32768;
    float y = 100.5;

    // numbers are represented in Q format with a multiplication 2^Q (shift bits left by Q places)
    // number represented in Q format is converted back by division with 2^Q

    /*
     * when converting the number from fixed to floating point arch., be careful about how many bits
     * are there in float type (takes only n MSB)
     */

    int32_t x_pom = x << Q;
    int32_t y_pom = y * (1 << Q);

    printf("Two numbers coverted to/from fixed point architecture\n");
    printf("%d = %f\n", x, (float)x_pom/(1<<Q));
    printf("%f = %f\n", y, (float)y_pom/(1<<Q));
}
