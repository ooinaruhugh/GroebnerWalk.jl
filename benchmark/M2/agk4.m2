
loadPackage "GroebnerWalk"



R1 = QQ[x,y,z,u,v, MonomialOrder =>{Weights =>{1,1,1,0,0}, Weights =>{0,0,0,1,1}, Weights =>{0,0,0,1,0}, Weights =>{1,1,0,0,0}, Weights =>{1,0,0,0,0}}]


I = ideal(    u + u^2 - 2*v - 2*u^2*v + 2*u*v^2 - x,
    -6*u + 2*v + v^2 - 5*v^3 + 2*u*v^2 - 4*u^2*v^2 - y,
    -2 + 2*u^2 + 6*v - 3*u^2*v^2 - z)



G = gb I 

R2 = QQ[x,y,z,u,v, MonomialOrder =>{Weights =>{0,0,0,1,1}, Weights =>{1,1,1,0,0}, Weights =>{1,1,0,0,0}, Weights =>{1,0,0,0,0}, Weights =>{0,0,0,1,0}}]

I2 = sub(I, R2) 
 

t1 = elapsedTiming G1 = gb I2

--setWalkTrace 3 
t2 = elapsedTiming G2 = groebnerWalk(G, R2) 

t3 = elapsedTiming G3 = groebnerWalk(G, R2, Strategy => Generic )

-- standard walk benchmark 

idealname = "agk4"
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
    flush out;
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


I = ideal(    u + u^2 - 2*v - 2*u^2*v + 2*u*v^2 - x,
    -6*u + 2*v + v^2 - 5*v^3 + 2*u*v^2 - 4*u^2*v^2 - y,
    -2 + 2*u^2 + 6*v - 3*u^2*v^2 - z)



G = gb I 

R2 = KK[x,y,z,u,v, MonomialOrder =>{Weights =>{0,0,0,1,1}, Weights =>{1,1,1,0,0}, Weights =>{1,1,0,0,0}, Weights =>{1,0,0,0,0}, Weights =>{0,0,0,1,0}}]

I2 = sub(I, R2) 
 

t1 = elapsedTiming G1 = gb I2

setWalkTrace 3 
t2 = elapsedTiming G2 = groebnerWalk(G, R2) 

t3 = elapsedTiming G3 = groebnerWalk(G, R2, Strategy => Generic )

-- standard walk benchmark 

idealname = "agk4"
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
