function y=plot_states(log_p_1)

figure
subplot(2,2,1)
plot(log_p_1(1:100,1));
title('First state');
subplot(2,2,2)
plot(log_p_1(1:100,2));
title('Seconde state');
subplot(2,2,3)
plot(log_p_1(1:100,3));
title('Third state');
subplot(2,2,4)
plot(log_p_1(1:100,4));
title('Fourth state');

y=0;
end