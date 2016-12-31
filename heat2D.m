function heat2D(X, Y, T, dx, dy, dt, kx, ky)
        ux=X/dx;
        uy=Y/dy;
        ut=T/dt;
        
        u=zeros(ux, uy);
        tmp=u;
        
        disp([ux uy]);
        
        x=2:ux-1;
        y=2:uy-1;
        t=2:ut-1;
        
        img=imread("MFF.png");
        cold=img(:, :, 1);
        hot=img(:, :, 2);
        for ii=1:ux
                for jj=1:uy
                        hot(ii, jj)=mod((hot(ii, jj)+cold(ii, jj)+1), 2);
                        if(hot(ii, jj)==0)
                                u(ii, jj)=100;
                        elseif(cold(ii, jj)==0)
                                u(ii, jj)=-20;
                        end
                end
        end
        tmp(1, :)=100;
        tmp(ux, :)=100;
        tmp(:, 1)=100;
        tmp(:, uy)=100;
        
        alfax=0.25;%kx*dt/dx^2;
        alfay=0.25;%ky*dt/dy^2;
        
        imagesc(u), axis equal, axis off;
        print("frame1", "-dpng");
        disp([alfax alfay]);
        for tt=t
                tmp(1, :)=100;
                tmp(ux, :)=100;
                tmp(:, 1)=100;
                tmp(:, uy)=100;
                disp(tt);
                for xx=x
                        for yy=y
                                tmp(xx, yy)=u(xx, yy)+alfax*(u(xx-1, yy)-2*u(xx, yy)+u(xx+1, yy))+alfay*(u(xx, yy-1)-2*u(xx, yy)+u(xx, yy+1));
                        end
                end
                u=tmp;
                for ii=1:ux
                        for jj=1:uy
                                if(hot(ii, jj)==0)
                                        u(ii, jj)=100;
                                elseif(cold(ii, jj)==0)
                                        u(ii, jj)=-20;
                                end
                        end
                end
                if(mod(tt, 5)==0)
                        imagesc(u), axis equal, axis off;
                        name=strcat("frame",mat2str(tt));
                        print(name, "-dpng");
                end

        end
        imagesc(u), axis equal;
end