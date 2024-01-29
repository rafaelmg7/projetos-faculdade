/**
 * @file   point.hpp
 * @brief  File containing the definition of a point
 * @author Rafael Martins Gomes
 * @date   2023-06-01
 */

#pragma once

#ifndef __POINT_hpp__
#define __POINT_hpp__


/**
 * Class representing a point
*/
class Point {
    public:
        Point(){
            this->x = -1;
            this->y = -1;
        }

        Point(int x, int y) : x(x), y(y){}

        friend int ccw(Point point1, Point point2, Point point3);
        friend int comparePoints(Point point0, Point point1, Point point2);
        friend void insertionSort(Point* points, Point p0, int begin, int size);
    private:
        int x, y;

    friend class ConvexHull;
};


#endif // __POINT_hpp__