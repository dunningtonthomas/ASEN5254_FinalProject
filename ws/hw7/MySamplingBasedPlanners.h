#pragma once

// This includes all of the necessary header files in the toolbox
#include "AMPCore.h"

// Include the correct homework headers
#include "hw/HW7.h"

// Include helper funtions
#include "helperFuncs.h"

// Include Astar class
#include "MyAStar.h"

// Include random library to get uniform sampling
#include <random>

class MyPRM : public amp::PRM2D {
    public:
        // Default constructor
        MyPRM() : n(400), r(3) {}

        // constructor to populate n and r
        MyPRM(int n, double r) : n(n), r(r) {}

        // @brief Find path using PRM
        virtual amp::Path2D plan(const amp::Problem2D& problem) override; 

        // @brief Create PRM Graph return the graph and the nodes map by reference
        std::shared_ptr<amp::Graph<double>> createGraph(const amp::Problem2D& problem, std::map<amp::Node, Eigen::Vector2d>& nodes);

    private:
        int n;
        double r;
};


class MyRRT : public amp::GoalBiasRRT2D {
    public:
        // Default constructor
        MyRRT() : step_size(0.5), goal_bias(0.05), max_iterations(5000), epsilon(0.25) {}

        // constructor to populate step_size, goal_bias, max_iterations, and epsilon
        MyRRT(double r, double p, int n, double e) : step_size(r), goal_bias(p), max_iterations(n), epsilon(e) {}


        // @brief Find path using RRT
        virtual amp::Path2D plan(const amp::Problem2D& problem) override; 

        // @brief Create the graph using RRT, return node map and parents map by reference
        std::shared_ptr<amp::Graph<double>> createGraph(const amp::Problem2D& problem, std::map<amp::Node, Eigen::Vector2d>& nodes, std::map<amp::Node, amp::Node>& parents);

        // @brief Find the nearest neighbor to a node in the graph
        amp::Node nearestNeighbor(const Eigen::Vector2d& q_rand, const std::map<amp::Node, Eigen::Vector2d>& nodes);

    private:
        double step_size;
        double goal_bias;
        int max_iterations;
        double epsilon;
};
