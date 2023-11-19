let variantFromDeriving = (~toJs, ~fromJs) => {
  let t_encode = value_type => value_type->toJs->Spice.intToJson
  let t_decode = j =>
    switch j->Spice.intFromJson {
    | Ok(int) =>
      switch int->fromJs {
      | Some(value_type) => value_type->Ok
      | _ => Spice.error("Not a value_type", j)
      }
    | _ => Spice.error("Not an integer", j)
    }
  (t_encode, t_decode)
}

/*

// Usage:

// In one step:

@deriving(jsConverter)
type t = | @as(0) Decimal

let (t_encode, t_decode) = GreenfinitySpice.Codecs.variantFromDeriving(
  ~toJs=tToJs,
  ~fromJs=tFromJs,
)

// or with two steps:

@deriving(jsConverter)
type t0 = | @as(0) Decimal

type t1 = @spice.codec(GreenfinitySpice.Codecs.variantFromDeriving(
  ~toJs=tToJs,
  ~fromJs=tFromJs,
)) t0

// Consuming:

@spice
type recordT = {
  // Via helper type:
  valueType: t
  valueType2: t1
  // OR directly:
  valueType3: @spice.codec(GreenfinitySpice.Codecs.variantFromDeriving(
    ~toJs=tToJs,
    ~fromJs=tFromJs,
  )) t0,
}


 */
