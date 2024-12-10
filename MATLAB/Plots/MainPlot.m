clc;
clear;
close all;

% Load Paths
filename = 'Data/PathPropagationRRT/adaptive_3.txt';
[x, y] = extractPath(filename);

% Load Planning Points
planning_points = load('Data/PathPropagationRRT/adaptive_flag_3.txt');
planning_points(end+1, :) = [x{end}(end), y{end}(end)];

% Find planning and divergence index
planning_index = findPlanningPoint(planning_points, x, y);
[divergence_index] = findDivergencePoint(x, y);
q_init = [x{1}(1), y{1}(1)];
q_goal = [x{end}(end), y{end}(end)];
sensing_radius = 100; % Define sensing radius for the agent

% Initialize Figure
figure(1);
hold on;
set(gcf, 'Units', 'normalized', 'OuterPosition', [0 0 1 1]);
marker_size = 120;
xlabel('X');
ylabel('Y');
axis equal;
grid on;
xlim([-5 35]);
ylim([-5 35]);
title('Path Planning with Obstacles');

% Plot Obstacles
obstacles = plotObstacles('Data/PathPropagationRRT/obstacles_3.txt');
for j = 1:size(obstacles, 1)
    % Extract obstacle properties
    obstacle_center = obstacles(j, 1:2);
    obstacle_radius = obstacles(j, 3);
    theta = linspace(0, 2*pi, 100);
    x_circle = obstacle_center(1) + obstacle_radius * cos(theta);
    y_circle = obstacle_center(2) + obstacle_radius * sin(theta);
    if checkPathIntersection(x{1}, y{1}, obstacle_center, obstacle_radius, sensing_radius)
        % Intersecting obstacle - red outline
        fill(x_circle, y_circle, 'r', 'EdgeColor', 'r', 'LineWidth', 1.5, 'FaceAlpha', 0.5, 'HandleVisibility', 'off');
    else
        % Non-intersecting obstacle
        fill(x_circle, y_circle, 'black', 'EdgeColor', 'none', 'FaceAlpha', 0.5, 'HandleVisibility', 'off');
    end
end
% Plot Start and Goal Points
scatter(q_init(1), q_init(2), marker_size, 'filled', 'MarkerFaceColor', 'b', 'MarkerEdgeColor', 'k', 'DisplayName', 'Start');
scatter(q_goal(1), q_goal(2), marker_size, 'filled', 'MarkerFaceColor', 'g', 'MarkerEdgeColor', 'k', 'DisplayName', 'Goal');

% Generate a colormap for path segments
num_segments = length(x);
colors = parula(num_segments+3);

% Plot Paths
start_index = divergence_index(1);
for i = 1:num_segments
    segment_color = colors(i, :);
    if i == 1
        % Plot initial path
        plot(x{i}, y{i}, 'LineWidth', 2, 'Color', segment_color, 'DisplayName', 'Initial Path');
        plot(x{i}(planning_index(i):divergence_index(i)), y{i}(planning_index(i):divergence_index(i)),'LineWidth', 2, 'Color', 'r', 'DisplayName', 'Planning Segment');
    else
        % Plot replanned paths
        plot(x{i}(start_index:divergence_index(i)), y{i}(start_index:divergence_index(i)), 'LineWidth', 2, 'Color', segment_color, 'DisplayName', ['Replanned Path ', num2str(i)]);
        plot(x{i}(divergence_index(i):end), y{i}(divergence_index(i):end), 'LineWidth', 2,'LineStyle','--' ,'Color', segment_color, 'HandleVisibility', 'off');

        % Plot planning segment
        plot(x{i}(planning_index(i):divergence_index(i)), y{i}(planning_index(i):divergence_index(i)),'LineWidth', 2, 'Color', 'r', 'HandleVisibility', 'off');
        start_index = divergence_index(i);
    end
end

% Add Legend
legend('Location', 'northeastoutside');
