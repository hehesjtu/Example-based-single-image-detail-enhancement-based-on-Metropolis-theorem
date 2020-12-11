function gimg = grad(img)
   fx = diff(img,1,2);
   fx = padarray(fx, [0 1 0], 'post');
   fy = diff(img,1,1);
   fy = padarray(fy, [1 0 0], 'post');
   gimg = abs(fx)+ abs (fy);
end

