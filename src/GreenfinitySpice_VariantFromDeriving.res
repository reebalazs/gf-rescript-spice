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
