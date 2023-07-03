function v = gammaCorrection(u, gamma)
c = 1;
if gamma < 1 || gamma > 1
    v = c*(u.^gamma);
end
end
