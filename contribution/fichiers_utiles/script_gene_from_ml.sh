#!/bin/bash

RACINE="/local/raynaudp/TER/CompCert_et_lib/CompCert"
MLD="fichier_mld"
DEST="extraction"
DEST2="fichier_mld/dvpmt_script"
MLIDEP="extraction.mli"
CHMN=$RACINE/$MLD
MLI=$CHMN/$MLIDEP
REP_SRC_EXTRACTION="src_modif"
SRC_EXTRACTION=$CHMN/$REP_SRC_EXTRACTION
REP_EXTRACTION_MLI="extraction.mli2"
REP_EXTRACTION_CMI="extraction.cmi2"
EXTRACTION_MLI=$CHMN/$REP_EXTRACTION_MLI
EXTRACTION_CMI=$CHMN/$REP_EXTRACTION_CMI
Paulo="Paulo"

VAR_PAULO="BinNums Datatypes Bool EquivDec BoolEqual String0 Errors Orders OrdersTac Nat BinPosDef BinPos BinNat BinInt Zbool Zpower Fcore_Zaux Fcore_FLT Fcore_digits Fcalc_bracket Fcalc_round Fappli_IEEE Archi List0 ZArith_dec Coqlib Integers Fappli_IEEE_bits Fappli_IEEE_extra Floats Maps Fappli_IEEE_bits Fappli_IEEE_extra Int0 OrderedType Ordered OrdersAlt OrdersFacts MSetInterface MSetAVL AST Op  FSetAVL Registers RTL"

MODIF="Compopts Equalities DecidableType FSetInterface Lattice PeanoNat Values Memdata ValueDomain ValueAOp Machregs Mach Asm Asmgen Cminor Compare_dec CminorSel ConstpropOp"

cd $CHMN
./scrit_recup_doc.sh	

VAR_PAULO2=`cat nom_extraction_modif.txt`	
#echo "fin des variables"


echo $VAR_PAULO
#echo $VAR_PAULO2




#actuellement PrinRTL depend de Paulo.ml donc indeispensable mais c'est seulement un test
#echo "boucle"
for d in $Paulo
do
	#echo $d
	cp $CHMN/test/$d.ml $RACINE/$DEST
done


echo "suprresion des cmi mli"
cd $EXTRACTION_CMI
rm -f *
cd $EXTRACTION_MLI
rm -f *
echo "generation des cmi mli"

#fichier dans driver necessaire pour certains fichier de MODIF
cp $RACINE/driver/Clflags.cmi $EXTRACTION_MLI
cp $RACINE/driver/Configuration.cmi $EXTRACTION_MLI

cp $RACINE/cfrontend/C2C.cmi $EXTRACTION_MLI



for x in $VAR_PAULO
do 
	echo "$x mli :"
	ocamlfind ocamlc -i -I $EXTRACTION_CMI   -package ppx_import -package ppx_deriving.show $SRC_EXTRACTION/$x.ml > $EXTRACTION_MLI/$x.mli ;
#les cmi généré restent dans le meme repertoire que les mli par conséquent nous n'avons pas besoin de rajouter de bibliothèque 
	echo "$x cmi :"
	ocamlfind ocamlc -c  -package ppx_import -package ppx_deriving.show $EXTRACTION_MLI/$x.mli
done

for x in $MODIF
do 
	echo "$x mli :"
	ocamlfind ocamlc -i -I $EXTRACTION_CMI -package ppx_import -package ppx_deriving.show $SRC_EXTRACTION/$x.ml > $EXTRACTION_MLI/$x.mli ;
#les cmi généré restent dans le meme repertoire que les mli par conséquent nous n'avons pas besoin de rajouter de bibliothèque 
	echo "$x cmi :"
	ocamlfind ocamlc -c -package ppx_import -package ppx_deriving.show $EXTRACTION_MLI/$x.mli
done
#gedit $EXTRACTION_MLI/Maps.mli &
#gedit $EXTRACTION_MLI/Maps.cmi &
#nous deplacons ensuite les .cmi dans un repertoire dédié
#mv $EXTRACTION_MLI/*.cmi $EXTRACTION_CMI




#la vrai boucle qui copie les fichier à terme nous utiliserons VAR_PAULO2
#echo "boucle2"
for f in $VAR_PAULO
do
	#echo $f
	cp $SRC_EXTRACTION/$f.ml $RACINE/$DEST
done


for f in $VAR_PAULO
do
#versionoriginale	\cp $MLI/$f.mli $RACINE/$DEST
	\cp $EXTRACTION_MLI/$f.mli $RACINE/$DEST
done

for f in $MODIF
do
	#echo $f
	cp $SRC_EXTRACTION/$f.ml $RACINE/$DEST
done

for f in $MODIF
do
#versionoriginale	\cp $MLI/$f.mli $RACINE/$DEST
	\cp $EXTRACTION_MLI/$f.mli $RACINE/$DEST
done





#copie du fichier PrinRTL.ml modifié dans backend
cp $CHMN/src_backend/* $RACINE/backend



 

