%% Càlculs problema 2
clearvars
close all

%Data
k1=12.0; f1=2;
k2=6.0; f2=4;

nodes = [0.0 ,0.0;
    2.0, 0.0;
    5.0, 0.0;
    0.0, 1.0;
    2.0, 1.0];

elem = [1, 2, 5, 4;
    5, 2, 3, 0];

dudy=2.0; %on the line joining nodes 4 and 5
q1_3=k1*dudy; 

%Rectangle: elem 1 
vertexsR=nodes(elem(1,:),:);
a = norm(vertexsR(2,:)-vertexsR(1,:));
b = norm(vertexsR(4,:)-vertexsR(1,:));

Psi1=@(x,y) (x-vertexsR(2,1))*(y-vertexsR(3,2))/a/b;
Psi2=@(x,y) -(x-vertexsR(1,1))*(y-vertexsR(3,2))/a/b;
Psi3=@(x,y) (x-vertexsR(1,1))*(y-vertexsR(1,2))/a/b;
Psi4=@(x,y) -(x-vertexsR(2,1))*(y-vertexsR(1,2))/a/b;

%Stifness Matrix
A=[2,-2,-1, 1;
  -2, 2, 1,-1;
  -1, 1, 2,-2;
   1,-1,-2, 2];

B=[2, 1,-1,-2;
   1, 2,-2,-1;
  -1,-2, 2, 1;
  -2,-1, 1, 2];


K=b*k1*A/a + a*k1*B/b;
K=K/6;

F=0.25*f1*a*b*[1;1;1;1];

Q1_33=q1_3*a/2; 

%Triangle: elem 2
vertexsT=nodes(elem(2,1:3),:);
a=norm(vertexsT(2,:)-vertexsT(1,:));
b=norm(vertexsT(3,:)-vertexsT(2,:));

b2=b*b;
a2=a*a;

A=[b2,   -b2,    0; 
  -b2, a2+b2,  -a2;
    0,   -a2,   a2];

L=0.5*k2*A/a/b;

G=f2*a*b*[1;1;1]/6;

%Natural B.C;
Q2_13=0.0; %q2_3=0 on the line joining nodes 3 and 5
Q5=Q1_33+Q2_13;

%Essential B.C.
U1=0.0;
U2=3*nodes(2,1);
U3=3*nodes(3,1);
U4=2*nodes(4,2);
um=[U1;U2;U3;U4];
k=[0.0,K(3,2)+L(1,2),0.0,K(3,4),K(3,3)+L(1,1)];
U5=(F(3)+G(1)+Q5-k(1:4)*um)/k(5); 
    
%Solutions
clc
fprintf( ...
['====================================================\n',...
 '                       PROB.2                       \n',...
 '====================================================\n',...
 '********************** PART A **********************\n',...
 'Psi1(2;0.5,0.5) = %.4e\n',...
 '********************** PART B **********************\n',...
 'K(5,2) = %.4e\n',...
 '********************** PART C **********************\n',...
 'F(5) = %.4e\n',... 
 '********************** PART D **********************\n',...
 'Q1_33 = %.4e\n',... 
 '********************** PART E **********************\n',...
 'U(5) = %.4e\n',...
 '****************************************************\n'],...
 Psi2(0.5,0.5), K(3,2)+L(1,2),F(3)+G(1),Q1_33,U5 ...
)





