#!/bin/bash

CHEMIN="/local/raynaudp/TER/CompCert_et_lib/CompCert/LIEN_AFFICHAGE/"
F_SRC="resultat_print.dot"
F_CIBLE="resultat_print.dot"
REP_CIBLE="/local/raynaudp/TER/projet/CC2HC/DEFENSE/template/LaTeX-7/"


cp $CHEMIN$F_SRC $REP_CIBLE$F_CIBLE
cd $REP_CIBLE
dot -Tpdf resultat_print.dot > resultat_print.pdf
