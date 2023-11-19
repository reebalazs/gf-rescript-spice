open Belt

let int64ToJson = (i): Js.Json.t => Int64.to_string(i)->Js.Json.string

let int64FromJson = j =>
  switch Js.Json.test((j: Js.Json.t), Js.Json.String) {
  | true => j->Js.Json.decodeString->Option.getExn->Int64.of_string->Ok
  | _ => Spice.error("Not a string", j)
  }

let int64AsString = (int64ToJson, int64FromJson)

/*

// Usage:

@spice
type xInt64 = @spice.codec(GreenfinitySpice.Codecs.int64AsString) int64
// let (xInt64_encode, xInt64_decode) = int64Codec


@spice
type t = {
  // Via helper type:
  id: xInt64,
  // OR directly:
  company_id: @spice.codec(GreenfinitySpice.Codecs.int64AsString) int64,
}


 */
