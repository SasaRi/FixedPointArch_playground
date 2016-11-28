/*
 * FixedPointArchitecture.xc
 *
 *  Created on: Nov 17, 2016
 *      Author: sasa
 */

#include <stdio.h>
#include <stdint.h>
#include <math.h>

int main()
{
    int16_t x = 750;   // 16 bit signed int [-32768, 32767]
    int16_t y = 100;
    int32_t x_pom, y_pom; // with Q16 format, 32 bits are enough to store arhitmetic operations of 16 bit var

    int64_t z;

    /*
     * when defining some number in Q format, number is shifted for Q decimal places
     * result number should have more bits as protection of overflows
     */

    x_pom = x << 10;


    /*
     * when converting the number from fixed to floating point arch., be careful about how many bits
     * are there in float type (takes only n MSB)
     */

    printf("%d %f %f\n", x_pom, (float)x_pom, (float)x_pom/(1<<10));

    y_pom = y << 10;

    /*
     * main problem with a multiplication is that result variable has to have enough integer bits
     * so overflow doesn't occur (that result isn't bigger than max.number of resulting type)
     * if overflow can happen, solution is to use numbers with less precision and more integer bits, i.e.
     * smaller Q format
     * test -> set inputs to max. values, reduce Q format until overflow in multiplication doesn't occur
     * multiplication result is always stored in a type with twice many bits as input variable
     * result is than casted back to previous type with dividing by 2^Q_FORMAT
     */

    z = (int64_t)x_pom * (int64_t)y_pom;

    int32_t w = z >> 10;

    printf("%d %f %f\n", w, (float)w, (float)w/(1<<10));

    return 0;
}
