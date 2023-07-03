function v = contrastStretching(u)
a = 0.4; b = 0.6;
alpha = 0.5;
beta = 0.5;
gamma = 1.5;
v_a = alpha*a;
v_b = beta*(b-a)+v_a;
v = zeros(size(u));
for i = 1:numel(u)
    if u(i) >= 0 && u(i) < a
        v(i) = alpha*u(i);
    elseif u(i) >= a && u(i) < b
        v(i) = beta*(u(i)-a)+v_a;
    elseif u(i) >= b && u(i) < 1
        v(i) = gamma*(u(i)-b)+v_b;
    end
end
end