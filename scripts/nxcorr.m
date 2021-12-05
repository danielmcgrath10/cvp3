function[nxcorr] = nxcorr(f, g)    
    f_hat = normalize(f);
    g_hat = normalize(g);
    nxcorr = sum(f_hat .* g_hat, 'all');
end
