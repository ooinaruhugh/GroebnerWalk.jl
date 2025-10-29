
restart 
loadPackage "GroebnerWalk"


R1 = QQ[x,y,z,u,v, MonomialOrder =>{Weights =>{1,1,1,0,0}, Weights =>{0,0,0,1,1}, Weights =>{0,0,0,1,0}, Weights =>{1,1,0,0,0}, Weights =>{1,0,0,0,0}}]


I = ideal(    -2000*x - 128*u^3*v^3 + 528*u^3*v^2 - 400*u^3 + 312*u^2*v^3 - 1287*u^2*v^2 + 975*u^2 - 120*u*v^3 + 495*u*v^2 - 375*u + 896*v^3 - 3696*v^2 + 2800,
  -2000*y - 128*u^3*v^3 - 144*u^3*v^2 + 672*u^3*v + 312*u^2*v^3 + 351*u^2*v^2 - 1638*u^2*v - 120*u*v^3 + 896*v^3 + 1008*v^2 - 4704*v,
  -160*z - 63*u^2 + 63*u + 384)




G = gb I 

R2 = QQ[x,y,z,u,v, MonomialOrder =>{Weights =>{0,0,0,1,1}, Weights =>{1,1,1,0,0}, Weights =>{1,1,0,0,0}, Weights =>{1,0,0,0,0}, Weights =>{0,0,0,1,0}}]

I2 = sub(I, R2) 
 

t1 = elapsedTiming G1 = gb I2

setWalkTrace 3 
t2 = elapsedTiming G2 = groebnerWalk(G, R2) 

t3 = elapsedTiming G3 = groebnerWalk(G, R2, Strategy => Generic )

-- standard walk benchmark 

idealname = "newell"
fieldname = "QQ"
alg = "standard"

filename = idealname | "_" | fieldname | "_" | alg | ".csv"
out = openOut filename; 
out << "trial,runtime\n";

totalTime = 0;
numTrials = 10;

for trial from 1 to numTrials do (
    t = (timing groebnerWalk(G,R2))#0;
    out << toString trial << "," << toString t << "\n";
    totalTime = totalTime + t;
);

avg = totalTime / numTrials;
out << "average," << toString avg << "\n";

close out;

-- generic walk benchmark 

alg = "generic"
filename = idealname | "_" | fieldname | "_" | alg | ".csv"

out = openOut filename; 
out << "trial,runtime\n";


totalTime = 0;
numTrials = 10;

for trial from 1 to numTrials do (
    t = (timing groebnerWalk(G,R2,Strategy => Generic ))#0;
    out << toString trial << "," << toString t << "\n";
    totalTime = totalTime + t;
);

avg = totalTime / numTrials;
out << "average," << toString avg << "\n";

close out;

restart 
loadPackage "GroebnerWalk"

KK = ZZ/11863279

R1 = KK[x,y,z,u,v, MonomialOrder =>{Weights =>{1,1,1,0,0}, Weights =>{0,0,0,1,1}, Weights =>{0,0,0,1,0}, Weights =>{1,1,0,0,0}, Weights =>{1,0,0,0,0}}]


I = ideal(    -2000*x - 128*u^3*v^3 + 528*u^3*v^2 - 400*u^3 + 312*u^2*v^3 - 1287*u^2*v^2 + 975*u^2 - 120*u*v^3 + 495*u*v^2 - 375*u + 896*v^3 - 3696*v^2 + 2800,
  -2000*y - 128*u^3*v^3 - 144*u^3*v^2 + 672*u^3*v + 312*u^2*v^3 + 351*u^2*v^2 - 1638*u^2*v - 120*u*v^3 + 896*v^3 + 1008*v^2 - 4704*v,
  -160*z - 63*u^2 + 63*u + 384)


G = gb I 

R2 = KK[x,y,z,u,v, MonomialOrder =>{Weights =>{0,0,0,1,1}, Weights =>{1,1,1,0,0}, Weights =>{1,1,0,0,0}, Weights =>{1,0,0,0,0}, Weights =>{0,0,0,1,0}}]

I2 = sub(I, R2) 
 

t1 = elapsedTiming G1 = gb I2

setWalkTrace 3 
t2 = elapsedTiming G2 = groebnerWalk(G, R2) 

t3 = elapsedTiming G3 = groebnerWalk(G, R2, Strategy => Generic )

-- standard walk benchmark 

idealname = "newell"
fieldname = "FF"
alg = "standard"

filename = idealname | "_" | fieldname | "_" | alg | ".csv"
out = openOut filename; 
out << "trial,runtime\n";

totalTime = 0;
numTrials = 10;

for trial from 1 to numTrials do (
    t = (timing groebnerWalk(G,R2))#0;
    out << toString trial << "," << toString t << "\n";
    totalTime = totalTime + t;
);

avg = totalTime / numTrials;
out << "average," << toString avg << "\n";

close out;

-- generic walk benchmark 

alg = "generic"
filename = idealname | "_" | fieldname | "_" | alg | ".csv"

out = openOut filename; 
out << "trial,runtime\n";


totalTime = 0;
numTrials = 10;

for trial from 1 to numTrials do (
    t = (timing groebnerWalk(G,R2,Strategy => Generic ))#0;
    out << toString trial << "," << toString t << "\n";
    totalTime = totalTime + t;
);

avg = totalTime / numTrials;
out << "average," << toString avg << "\n";

close out;
restart 
