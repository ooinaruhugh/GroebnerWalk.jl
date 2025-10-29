-- katsura 8

-- over QQ 
restart 
loadPackage "GroebnerWalk"
R1 = QQ[x1, x2, x3, x4, x5, x6, x7, x8,x9]

I = ideal(  -x1+2*x9^2+2*x8^2+2*x7^2+2*x6^2+2*x5^2+2*x4^2+2*x3^2+2*x2^2+x1^2,
 -x2+2*x9*x8+2*x8*x7+2*x7*x6+2*x6*x5+2*x5*x4+2*x4*x3+2*x3*x2+2*x2*x1,
 -x3+2*x9*x7+2*x8*x6+2*x7*x5+2*x6*x4+2*x5*x3+2*x4*x2+2*x3*x1+x2^2,
 -x4+2*x9*x6+2*x8*x5+2*x7*x4+2*x6*x3+2*x5*x2+2*x4*x1+2*x3*x2,
 -x5+2*x9*x5+2*x8*x4+2*x7*x3+2*x6*x2+2*x5*x1+2*x4*x2+x3^2,
 -x6+2*x9*x4+2*x8*x3+2*x7*x2+2*x6*x1+2*x5*x2+2*x4*x3,
 -x7+2*x9*x3+2*x8*x2+2*x7*x1+2*x6*x2+2*x5*x3+x4^2,
 -x8+2*x9*x2+2*x8*x1+2*x7*x2+2*x6*x3+2*x5*x4,
 -1+2*x9+2*x8+2*x7+2*x6+2*x5+2*x4+2*x3+2*x2+x1
)

R2 = QQ[x1, x2, x3, x4, x5, x6, x7, x8,x9, MonomialOrder => {Weights =>{1,0,0,0,0,0,0,0,0}, Weights => {0,1,0,0,0,0,0,0,0}, Weights =>{0,0,1,0,0,0,0,0,0,0}, Weights => {0,0,0,1,0,0,0,0,0}, Weights =>{0,0,0,0,1,0,0,0,0}, Weights => {0,0,0,0,0,1,0,0,0}, Weights =>{0,0,0,0,0,0,1,0,0},Weights =>{0,0,0,0,0,0,0,1,0}} ]


I2 = sub(I, R2)

G = gb I 
t1 = elapsedTiming G1 = gb I2

setWalkTrace 3 

t2 = elapsedTiming G2 = groebnerWalk(forceGB gens I, R2) 

setWalkTrace 3 
t3 = elapsedTiming G5 = groebnerWalk(G, R2, Strategy => Generic)


-- standard walk benchmark 

idealname = "katsura8"
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



-- over finite field
restart 
loadPackage "GroebnerWalk"
KK = ZZ/11863279

R1 = KK[x1, x2, x3, x4, x5, x6, x7, x8,x9]

I = ideal(  -x1+2*x9^2+2*x8^2+2*x7^2+2*x6^2+2*x5^2+2*x4^2+2*x3^2+2*x2^2+x1^2,
 -x2+2*x9*x8+2*x8*x7+2*x7*x6+2*x6*x5+2*x5*x4+2*x4*x3+2*x3*x2+2*x2*x1,
 -x3+2*x9*x7+2*x8*x6+2*x7*x5+2*x6*x4+2*x5*x3+2*x4*x2+2*x3*x1+x2^2,
 -x4+2*x9*x6+2*x8*x5+2*x7*x4+2*x6*x3+2*x5*x2+2*x4*x1+2*x3*x2,
 -x5+2*x9*x5+2*x8*x4+2*x7*x3+2*x6*x2+2*x5*x1+2*x4*x2+x3^2,
 -x6+2*x9*x4+2*x8*x3+2*x7*x2+2*x6*x1+2*x5*x2+2*x4*x3,
 -x7+2*x9*x3+2*x8*x2+2*x7*x1+2*x6*x2+2*x5*x3+x4^2,
 -x8+2*x9*x2+2*x8*x1+2*x7*x2+2*x6*x3+2*x5*x4,
 -1+2*x9+2*x8+2*x7+2*x6+2*x5+2*x4+2*x3+2*x2+x1,
)

R2 = KK[x1, x2, x3, x4, x5, x6, x7, x8,x9, MonomialOrder => {Weights =>{1,0,0,0,0,0,0,0,0}, Weights => {0,1,0,0,0,0,0,0,0}, Weights =>{0,0,1,0,0,0,0,0,0,0}, Weights => {0,0,0,1,0,0,0,0,0}, Weights =>{0,0,0,0,1,0,0,0,0}, Weights => {0,0,0,0,0,1,0,0,0}, Weights =>{0,0,0,0,0,0,1,0,0},Weights =>{0,0,0,0,0,0,0,1,0}} ]

I2 = sub(I, R2)

G = gb I 
t1 = elapsedTiming G1 = gb I2

t2 = elapsedTiming G2 = groebnerWalk(G, R2) 

setWalkTrace 3 
t3 = elapsedTiming G5 = groebnerWalk(G, R2, Strategy => Generic)

-- standard walk benchmark 

idealname = "katsura8"
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


