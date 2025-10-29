
restart
loadPackage "GroebnerWalk"

--katsura6 

--over QQ

R1 = QQ[x1,x2,x3,x4,x5,x6,x7] 

I = ideal(         1*x1+2*x2+2*x3+2*x4+2*x5+2*x6+2*x7-1,
        2*x4*x3+2*x5*x2+2*x6*x1+2*x7*x2-1*x6,
        1*x3^2+2*x4*x2+2*x5*x1+2*x6*x2+2*x7*x3-1*x5,
        2*x3*x2+2*x4*x1+2*x5*x2+2*x6*x3+2*x7*x4-1*x4,
        1*x2^2+2*x3*x1+2*x4*x2+2*x5*x3+2*x6*x4+2*x7*x5-1*x3,
        2*x2*x1+2*x3*x2+2*x4*x3+2*x5*x4+2*x6*x5+2*x7*x6-1*x2,
        1*x1^2+2*x2^2+2*x3^2+2*x4^2+2*x5^2+2*x6^2+2*x7^2-1*x1 )
  

R2 = QQ[x1,x2,x3,x4,x5,x6,x7, MonomialOrder => {Weights =>{1,0,0,0,0,0,0}, Weights => {0,1,0,0,0,0,0}, Weights =>{0,0,1,0,0,0,0,0}, Weights => {0,0,0,1,0,0,0}, Weights =>{0,0,0,0,1,0,0}, Weights => {0,0,0,0,0,1,0}, Weights =>{0,0,0,0,0,0,1}}]


I2 = sub(I, R2)

G = gb I 
t1 = elapsedTiming G1 = gb I2

t2 = elapsedTiming G2 = groebnerWalk(G, R2) 


t3 = elapsedTiming G5 = groebnerWalk(G, R2, Strategy => Generic)

-- standard walk benchmark 

idealname = "katsura6"
fieldname = "QQ"
alg = "standard"

filename = idealname | "_" | fieldname | "_" | alg | ".csv"
out = openOut filename; 
out << "trial,runtime\n";

flush out;

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


--over finite field 

restart 

loadPackage "GroebnerWalk"

KK = ZZ/11863279
R1 = KK[x1,x2,x3,x4,x5,x6,x7] 

I = ideal(         1*x1+2*x2+2*x3+2*x4+2*x5+2*x6+2*x7-1,
        2*x4*x3+2*x5*x2+2*x6*x1+2*x7*x2-1*x6,
        1*x3^2+2*x4*x2+2*x5*x1+2*x6*x2+2*x7*x3-1*x5,
        2*x3*x2+2*x4*x1+2*x5*x2+2*x6*x3+2*x7*x4-1*x4,
        1*x2^2+2*x3*x1+2*x4*x2+2*x5*x3+2*x6*x4+2*x7*x5-1*x3,
        2*x2*x1+2*x3*x2+2*x4*x3+2*x5*x4+2*x6*x5+2*x7*x6-1*x2,
        1*x1^2+2*x2^2+2*x3^2+2*x4^2+2*x5^2+2*x6^2+2*x7^2-1*x1 )
  

R2 = KK[x1,x2,x3,x4,x5,x6,x7, MonomialOrder => {Weights =>{1,0,0,0,0,0,0}, Weights => {0,1,0,0,0,0,0}, Weights =>{0,0,1,0,0,0,0,0}, Weights => {0,0,0,1,0,0,0}, Weights =>{0,0,0,0,1,0,0}, Weights => {0,0,0,0,0,1,0}, Weights =>{0,0,0,0,0,0,1}}]

I2 = sub(I, R2)

G = gb I 
t1 = elapsedTiming G1 = gb I2

setWalkTrace 3 
t2 = elapsedTiming G2 = groebnerWalk(G, R2) 


t3 = elapsedTiming G5 = groebnerWalk(G, R2, Strategy => Generic)

-- standard walk benchmark 

idealname = "katsura6"
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


