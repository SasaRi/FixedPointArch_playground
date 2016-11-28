/*
 * division.xc
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

int32_t q_div(int32_t a, int32_t b)
{
    int32_t result;
    int64_t temp;

    // pre-multiply by the base (Upscale to Q16 so that the result will be in Q8 format)
    temp = (int64_t)a << Q;

    result = (int32_t)(temp / b);

    return result;
}

void division()
{
    int16_t x = 32767;   // 16 bit signed int [-32768, 32767]
    int16_t y = 5;

    int32_t x_pom, y_pom; // with Q16 format, 32 bits are enough to store arhitmetic operations of 16 bit var

    /*
     * when defining some number in Q format, number is shifted for Q decimal places
     * result number should have more bits as protection of overflows
     */

    x_pom = x << Q;
    y_pom = y << Q;

    int32_t h = q_div(x_pom, y_pom);

    printf("\nDivision of two numbers with same number of fractional bits\n");
    printf("%d / %d = %f\n", x, y, (float)h/(1<<Q));
}

