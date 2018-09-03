
type positive =
| Coq_xI of positive
| Coq_xO of positive
| Coq_xH
  [@@deriving show]

type coq_N =
| N0
| Npos of positive
  [@@deriving show]

type coq_Z =
| Z0
| Zpos of positive
| Zneg of positive
  [@@deriving show]
