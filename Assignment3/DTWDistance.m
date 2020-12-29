function DTWDistance(s=[zeros(1,n)],t=[zeros(1,m)],int w)
    DTW = [zeros(1,n),zeros(1,m)]
    w = max(w, abs(n-m))
    for i = 0:n
        for j = 0:m
            DTW[i,j] = infinity
        end
    DTW[0,0] = 0
    end
    
    for i = 1:n
        for j = max(1, i-w):min(m, i+w)
            cost = d(s[i],t[j])
            DTW[i,j] = cost + min(DTW[i-1,j],DTW[i,j-i],DTW[i-1,j-1])
            return DTW[n,m]
        end
    end
end