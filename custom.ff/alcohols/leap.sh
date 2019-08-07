# Prepare molecule for simulation
# 1) Run AM1BCC w/ antechamber
# 2) Check for missing parameters
# 3) Prepare leap file from template
# 4) Run tleap to get amber topology

file=$1
resname=$2
intype=pdb
outtype=mol2

module load amber/amber16
: '
# === Run Antechamber ===
antechamber -i $file.$intype -fi $intype -o $file.$outtype -fo $outtype -rn $resname -c bcc -pf y -s 2

# === Run Parameter Check === 
parmchk2 -i $file.$outtype -f $outtype -o $file.frcmod

# === Create tleap File ===
leapfile=$file.leap.in
sed "s/__filetype__/${outtype}/g" ../template.leap.in > $leapfile
sed -i "s/__name__/${file}/g" $leapfile

# === Create Amber Topology with tleap ===
tleap -f $leapfile > $file.leap.out
'
# === Convert to Gromacs using parmed ===
: '
python -c "
import parmed
amber = parmed.load_file('${file}.parm7', xyz='${file}.rst7')
amber.save( '${file}.top', parameters='${file}.itp' )
amber.save( '${file}.gro' )
"
'
python ../amber2gro.py $file
python ../hydroxynator.py ${file}.top -s 1 -e 1 -o ${file}_scaled.top


