#!/bin/bash
#
#3> <> prov:specializationOf <https://github.com/timrdf/prov-wg/tree/master/namespace/bin/copy-to-w3-csv.sh>;
#3>    prov:wasDerivedFrom   <https://github.com/timrdf/prov-wg/issues/13>;
#3> .

HOME=$(cd ${0%/*} && echo ${PWD})               # e.g. prov-wg/namespace/bin
PROV_WG=$(cd $HOME && cd ../../ && echo ${PWD}) # e.g. prov-wg

W3C_ERRATA_HOME='../../WWW' # '../TODO/ivan-add-path-here'
W3C_NS_HOME='../../WWW'     # '../TODO/ivan-add-another-path-here'


function cp_if_diff() {
   from="$1"
   to="$2"

   diffs=`diff --brief  "$from" "$to"`
   if [[ -e "$from" && ( ! -e "$to" || ${#diffs} -gt 0 ) ]]; then
      echo "UPDATED $to"
      cp "$from" "$to"
   else
      echo "OK $to"
   fi
}

pushd $PROV_WG &> /dev/null
   cp_if_diff                            "errata.html" \
              "$W3C_ERRATA_HOME/2011/prov/errata.html"
   for ns in prov-links prov-aq prov-o-inverses; do
      for ext in ttl owl; do
         cp_if_diff       "namespace/$ns.$ext" \
                    "$W3C_NS_HOME/ns/$ns.$ext"
      done
   done
popd &> /dev/null

exit $status
