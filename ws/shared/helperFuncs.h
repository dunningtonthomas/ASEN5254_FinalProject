#pragma once

#include "AMPCore.h"
#include "Eigen/Geometry"
#include "hw/HW2.h"
#include "hw/HW4.h"
#include <cstdlib>
#include <iostream>
#include <cmath>
#include <algorithm>

namespace amp{
    // @brief Print the vertices of an obstacle
    void printVertices(std::vector<Eigen::Vector2d>& vertices);

    // @brief Calculate the minkowski sum of two polygons
    Polygon minkowski(amp::Polygon& obstacle, amp::Polygon& negative_object);

    // @brief Calculate the angle of a side of a polygon relative to horizontal
    double angle(Eigen::Vector2d v1, Eigen::Vector2d v2);

    // @brief Sort the vertices of a polygon in counter clockwise order such that the first vertex is the smallest y coordinate
    std::vector<Eigen::Vector2d> sortVerticesCCW(std::vector<Eigen::Vector2d> vertices);

    // @brief Rotate a polygon by a given angle
    Polygon rotatePolygon(amp::Polygon& obstacle, double angle);

    // @brief Return the negative of the vertices of a polygon
    std::vector<Eigen::Vector2d> negativeVertices(std::vector<Eigen::Vector2d>& vertices);

} // namespace amp



