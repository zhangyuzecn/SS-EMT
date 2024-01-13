function dominance_relation = compareDominanceRelationship(x, y, IE, MI, D)
%% Compare the dominance relationship between two particles
% Determines the dominance relationship between particle x and y.
% Returns 1 if x dominates y, -1 if y dominates x, and 0 if they are mutually non-dominating.

dominance_relation = 0;

% Calculate the objective vectors for particles x and y
gx = fitness(x, IE, MI, D);
gy = fitness(y, IE, MI, D);

% Check if x dominates y
if all(gx <= gy) && any(gx < gy)
    dominance_relation = 1;
end

% Check if y dominates x
if all(gy <= gx) && any(gy < gx)
    dominance_relation = -1;
end

end
