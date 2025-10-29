restart 
loadPackage "GroebnerWalk"
--cyclic5 
--over QQ
R1 = QQ[a,b,c,d,x]

I = ideal( a + b + c + d + x,
a*b + b*c + c*d + d*x + x*a,
a*b*c + b*c*d + c*d*x + d*x*a + x*a*b,
a*b*c*d + b*c*d*x + c*d*x*a + d*x*a*b + x*a*b*c,
a*b*c*d*x - 1 )

-- run functions once to check that it terminates 
R2 = QQ[a,b,c,d,x, MonomialOrder => Lex]


I2 = sub(I, R2)

G = gb I 
t1 = elapsedTiming G1 = gb I2

t2 = elapsedTiming G2 = groebnerWalk(G, R2) 


t3 = elapsedTiming G5 = groebnerWalk(G, R2, Strategy => Generic)

-- standard walk benchmark 

idealname = "cyclic5"
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
R1 = KK[a,b,c,d,x]

I = ideal( a + b + c + d + x,
a*b + b*c + c*d + d*x + x*a,
a*b*c + b*c*d + c*d*x + d*x*a + x*a*b,
a*b*c*d + b*c*d*x + c*d*x*a + d*x*a*b + x*a*b*c,
a*b*c*d*x - 1 )

R2 = KK[a,b,c,d,x, MonomialOrder => Lex]


I2 = sub(I, R2)

G = gb I 
t1 = elapsedTiming G1 = gb I2

t2 = elapsedTiming G2 = groebnerWalk(G, R2) 


t3 = elapsedTiming G5 = groebnerWalk(G, R2, Strategy => Generic) -- division by non-unit attempted? hm. 


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



