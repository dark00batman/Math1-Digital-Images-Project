% ========================================================
% 1. Define the Matrix
% ========================================================
% 0 = Black (Background), 1 = White (Features)
M = [
    0 0 0 0 0 0 0 0;
    0 0 0 0 0 0 0 0;
    0 1 1 0 0 1 1 0;
    0 1 1 0 0 1 1 0;
    0 0 0 1 1 0 0 0;
    0 0 1 1 1 1 0 0;
    0 0 1 0 0 1 0 0;
    0 0 0 0 0 0 0 0;
];

% Upscale the matrix to 16x16 (repeating elements 2x2)
DisplayMatrix = repelem(M, 2, 2); 
[rows, cols] = size(DisplayMatrix);

% ========================================================
% 2. Setup the Figure
% ========================================================
figure('Color', 'w', 'Position', [100, 100, 1200, 600]);
t = tiledlayout(1, 2, 'Padding', 'compact', 'TileSpacing', 'loose'); 

% --------------------------------------------------------
% (Left) Pixel View
% --------------------------------------------------------
ax1 = nexttile;
imagesc(DisplayMatrix + 1);    % Shift values to 1 & 2 for colormap
colormap(ax1, [0 0 0; 1 1 1]); % Map: 1->Black, 2->White
axis image; 

% Set limits tightly to remove gray margins
xlim([0.5, cols+0.5]);
ylim([0.5, rows+0.5]);
grid on;

% Configure grid and hide external border
set(gca, 'XTick', 0.5:1:cols+0.5, 'YTick', 0.5:1:rows+0.5, ...
    'XTickLabel', [], 'YTickLabel', [], ...
    'GridColor', [0.5 0.5 0.5], 'GridAlpha', 1, 'LineWidth', 1, ...
    'XColor', 'none', 'YColor', 'none');

% Title settings
title('Pixel View', ...
    'FontSize', 14, ...
    'Color', 'k', ...       
    'FontWeight', 'bold'); 

% --------------------------------------------------------
% (Right) Matrix Representation
% --------------------------------------------------------
ax2 = nexttile;
hold on;
set(gca, 'YDir', 'reverse'); 
axis image; axis off; 

% 1. Write the numbers
for r = 1:rows
    for c = 1:cols
        val = DisplayMatrix(r, c);
        if val == 0
            % 0s: Black and Bold
            text(c, r, '0', 'FontName', 'Consolas', 'FontSize', 10, ...
                'FontWeight', 'bold', 'Color', 'k', 'HorizontalAlignment', 'center');
        else
            % 1s: Gray and Normal
            text(c, r, '1', 'FontName', 'Consolas', 'FontSize', 10, ...
                'FontWeight', 'normal', 'Color', [0.7 0.7 0.7], 'HorizontalAlignment', 'center');
        end
    end
end

% 2. Draw Brackets
topY = 0.3; bottomY = rows + 0.7;

% Left Bracket
line([0.6, -0.3, -0.3, 0.6], [topY, topY, bottomY, bottomY], 'Color', 'k', 'LineWidth', 3);

% Right Bracket
line([cols+0.4, cols+1.3, cols+1.3, cols+0.4], [topY, topY, bottomY, bottomY], 'Color', 'k', 'LineWidth', 3);

% 3. Write Size Label
text(cols+1.3, bottomY + 1, sprintf('%dx%d', rows, cols), ...
    'FontName', 'Consolas', ...
    'FontSize', 12, ...
    'FontWeight', 'bold', ...
    'Color', 'k', ...
    'HorizontalAlignment', 'right');

% Set limits for the right plot
xlim(ax2, [-0.5, cols+1.5]);
ylim(ax2, [0, rows+2]);

% Title settings
title('Matrix Representation', ...
    'FontSize', 14, ...
    'Color', 'k', ...       
    'FontWeight', 'bold');