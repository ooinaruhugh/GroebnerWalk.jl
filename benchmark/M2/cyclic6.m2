
restart
loadPackage "GroebnerWalk"

--cyclic6 

--over QQ
R1 = QQ[z0,z1,z2,z3,z4,z5] 

I = ideal(       z0 + z1 + z2 + z3 + z4 + z5,
      z0*z1 + z1*z2 + z2*z3 + z3*z4 + z4*z5 + z5*z0,
      z0*z1*z2 + z1*z2*z3 + z2*z3*z4 + z3*z4*z5 + z4*z5*z0 + z5*z0*z1,
      z0*z1*z2*z3 + z1*z2*z3*z4 + z2*z3*z4*z5 + z3*z4*z5*z0 + z4*z5*z0*z1 
      + z5*z0*z1*z2,
      z0*z1*z2*z3*z4 + z1*z2*z3*z4*z5 + z2*z3*z4*z5*z0 + z3*z4*z5*z0*z1 
      + z4*z5*z0*z1*z2 + z5*z0*z1*z2*z3,
      z0*z1*z2*z3*z4*z5 - 1 )

R2 = QQ[z0,z1,z2,z3,z4,z5, MonomialOrder => {Weights =>{1,0,0,0,0,0}, Weights => {0,1,0,0,0,0}, Weights =>{0,0,1,0,0,0,0}, Weights => {0,0,0,1,0,0}, Weights =>{0,0,0,0,1,0}, Weights => {0,0,0,0,0,1} }]


I2 = sub(I, R2)

G = gb I 
t1 = elapsedTiming G1 = gb I2

t2 = elapsedTiming G2 = groebnerWalk(G, R2) 


t3 = elapsedTiming G5 = groebnerWalk(G, R2, Strategy => Generic)

-- standard walk benchmark 

idealname = "cyclic6"
fieldname = "QQ"
alg = "standard"

filename = idealname | "_" | fieldname | "_" | alg | ".csv"
out = openOut filename; 
out << "trial,runtime\n";

totalTime = 0;
numTrials = 100;

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
numTrials = 100;

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
--over finite field 
KK = ZZ/11863279
R1 = KK[z0,z1,z2,z3,z4,z5] 

I = ideal(       z0 + z1 + z2 + z3 + z4 + z5,
      z0*z1 + z1*z2 + z2*z3 + z3*z4 + z4*z5 + z5*z0,
      z0*z1*z2 + z1*z2*z3 + z2*z3*z4 + z3*z4*z5 + z4*z5*z0 + z5*z0*z1,
      z0*z1*z2*z3 + z1*z2*z3*z4 + z2*z3*z4*z5 + z3*z4*z5*z0 + z4*z5*z0*z1 
      + z5*z0*z1*z2,
      z0*z1*z2*z3*z4 + z1*z2*z3*z4*z5 + z2*z3*z4*z5*z0 + z3*z4*z5*z0*z1 
      + z4*z5*z0*z1*z2 + z5*z0*z1*z2*z3,
      z0*z1*z2*z3*z4*z5 - 1 )

R2 = KK[z0,z1,z2,z3,z4,z5, MonomialOrder => {Weights =>{1,0,0,0,0,0}, Weights => {0,1,0,0,0,0}, Weights =>{0,0,1,0,0,0,0}, Weights => {0,0,0,1,0,0}, Weights =>{0,0,0,0,1,0}, Weights => {0,0,0,0,0,1} }]



I2 = sub(I, R2)

G = gb I --why does this take longer than the QQ case? probabilistic something or other? 
t1 = elapsedTiming G1 = gb I2 --also doesn't terminate
t2 = elapsedTiming G2 = groebnerWalk(G, R2) 


t3 = elapsedTiming G5 = groebnerWalk(G, R2, Strategy => Generic)


-- standard walk benchmark 

idealname = "cyclic5"
fieldname = "FF"
alg = "standard"

filename = idealname | "_" | fieldname | "_" | alg | ".csv"
out = openOut filename; 
out << "trial,runtime\n";

totalTime = 0;
numTrials = 100;

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
numTrials = 100;

for trial from 1 to numTrials do (
    t = (timing groebnerWalk(G,R2,Strategy => Generic ))#0;
    out << toString trial << "," << toString t << "\n";
    totalTime = totalTime + t;
);

avg = totalTime / numTrials;
out << "average," << toString avg << "\n";

close out;


restart
