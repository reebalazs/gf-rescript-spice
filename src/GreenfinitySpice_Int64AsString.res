let int64ToJson = (i): Js.Json.t => Int64.to_string(i)->Js.Json.string

let int64FromJson = j =>
  switch (j: Js.Json.t) {
  | Js.Json.String(s) => s->Int64.of_string->Ok
  | _ => Spice.error("Not a string", j)
  }

let int64AsString = (int64ToJson, int64FromJson)
