/*
 * multiplication.xc
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
#define Q 3
#define ADC_VREF 2500UL
#define ADC_BITS 0x7fff

int32_t q_mul(int32_t a, int32_t b)
{
    int32_t result;
    int64_t temp;

    temp = (int64_t)a * (int64_t)b; // result type is operand's type
    // Correct by dividing by base and saturate result
    result = temp >> Q;

    return result;
}

void multiplication()
{
    int16_t x = 32767;   // 16 bit signed int [-32768, 32767]
    int16_t y = ADC_VREF;
    int16_t z = ADC_BITS;

    int32_t x_pom, y_pom, z_pom; // with Q16 format, 32 bits are enough to store arhitmetic operations of 16 bit var

    /*
     * when defining some number in Q format, number is shifted for Q decimal places
     * result number should have more bits as protection of overflows
     */

    x_pom = x << Q;
    y_pom = y << Q;
    z_pom = (int32_t)z;

    /*
     * generally multiplying two numbers x (a.b format) * y (c.d format) results in a a+b.c+d format
     * if both numbers have the same Q format, result is then divided by 2^Q_FORMAT
     * why ? res = x * 2^Q * y * 2^Q = x * y * 2^Q * 2^Q -> have to divide by 2^Q if to stay in Q format
     *
     * easiest way is to leave one number with 0 fractional bits, i.e result has the same number
     * of fractional bits as first operand
     * result is not divided by 2^Q_FORMAT
     * why ? res = x * 2^Q * y = x * y * 2^Q -> already in Q format
     *
     * multiplication result is always stored in a type with twice many bits as input variable
     * main problem with a multiplication is that result variable has to have enough integer bits
     * so overflow doesn't occur (that result isn't bigger than max.number of resulting type)
     * if overflow can happen, solution is to use numbers with less precision and more integer bits, i.e.
     * smaller Q format
     *
     * result is than casted back to previous type with dividing by 2^Q_FORMAT
     */

    int32_t h = q_mul(x_pom, y_pom);

    printf("\nMultiplication of two numbers with same number of fractional bits\n");
    printf("%d * %d = %f\n", x, y, (float)h/(1<<Q));

    int Q_help = 16;
    x_pom = x << Q_help;
    y_pom = y;

    int64_t w = (int64_t)x_pom * (int64_t)y_pom;  // result is in Q16 format (48 integer + 16 fractional bits)

    printf("\nMultiplication of two numbers where one number has 0 fractional bits\n");
    printf("%d * %d = %f\n", x, y, (float)w/(1<<Q_help));
}

