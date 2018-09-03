val eval_static_condition :
  Op.condition -> ValueDomain.aval list -> ValueDomain.abool
val eval_static_addressing_32 :
  Op.addressing -> ValueDomain.aval list -> ValueDomain.aval
val eval_static_addressing_64 :
  Op.addressing -> ValueDomain.aval list -> ValueDomain.aval
val eval_static_addressing :
  Op.addressing -> ValueDomain.aval list -> ValueDomain.aval
val eval_static_operation :
  Op.operation -> ValueDomain.aval list -> ValueDomain.aval
