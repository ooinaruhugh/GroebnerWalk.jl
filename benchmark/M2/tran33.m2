--chap4 ideal (Tran2000, example 3.3) 

loadPackage "GroebnerWalk"
--over QQ
R1 = QQ[x,y,z]
I = ideal(6 + 3*x^3+16*x^2*z+14*x^2*y^3, 6+y^3*z+17*x^2*z^2+7*x*y^2*z^2+13*x^3*z^2)

R2 = QQ[x,y,z, MonomialOrder =>{Weights=>{1,0,0}, Weights => {0,1,0}, Weights => {0,0,1}} ]

I2 = sub(I, R2)

G = gb I 
t1 = elapsedTiming G1 = gb I2

--setWalkTrace 3 
t2 = elapsedTiming G2 = groebnerWalk(G, R2) 


t3 = elapsedTiming G5 = groebnerWalk(G, R2, Strategy => Generic)


-- standard walk benchmark 

idealname = "tran33"
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



--over finite field 
restart
loadPackage "GroebnerWalk"
KK = ZZ/11863279
R1 = KK[x,y,z]
I = ideal(6 + 3*x^3+16*x^2*z+14*x^2*y^3, 6+y^3*z+17*x^2*z^2+7*x*y^2*z^2+13*x^3*z^2)

R2 = KK[x,y,z, MonomialOrder =>{Weights=>{1,0,0}, Weights => {0,1,0}, Weights => {0,0,1}} ]

I2 = sub(I, R2)

G = gb I 
t1 = elapsedTiming G1 = gb I2

t2 = elapsedTiming G2 = groebnerWalk(G, R2) 


t3 = elapsedTiming G5 = groebnerWalk(G, R2, Strategy => Generic)

-- standard walk benchmark 

idealname = "tran33"
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
