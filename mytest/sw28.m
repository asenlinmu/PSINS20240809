function [imu, avp, gps, xyz, t0] = sw28(fname, t0)
% 	double seq, time, exp_time, enu_x, enu_y, enu_z, enu_rx, enu_ry, enu_rz, enu_vx, enu_vy, enu_vz, 
% 		acc_x, acc_y, acc_z, g_x, g_y, g_z, lon, lat, alt, speed, heading, gps_lon, gps_lat, gps_alt, sat_htop, fix_type;
global glv
    dd = load(fname);
    if nargin<2, t0=dd(1,2); end
    dd(:,2) = dd(:,2)-t0;  % ttest(dd(:,2))
    % binfile(fnameext(fname,'bin'),dd);
    idx = dd(:,27)>0;
    gps = [vy2vn(dd(idx,22),-dd(idx,23)*glv.deg), dd(idx,[25,24])*glv.deg,dd(idx,[26,27,2])]; %  gpsplot(gps); gpssatplot(gps(:,end-1:end));
    avp = [dd(:, 7:9)*glv.deg, dd(:, 10:12), dd(:,[20,19])*glv.deg, dd(:,[21,2])]; % insplot(avp);
    imu = [dd(:,[16:18,13:15])*0.01, dd(:,2)]; % imuplot(imu);
    xyz = dd(:, [4:6,2]);  % miniplot(xyz, 'xyz');
