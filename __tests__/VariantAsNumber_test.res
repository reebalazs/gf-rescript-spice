open Jest

@spice
type t =
  | @spice.as(1.0) Foo
  | @spice.as(2.0) Bar

describe("variant encoded as number", () => {
  open Expect
  open! Expect.Operators

  describe("Foo", () => {
    let j = Foo->t_encode
    test("encodes", () => j->Js.Json.classify->expect->toEqual(1.0->Js.Json.JSONNumber))
    test("decodes", () => j->t_decode->Belt.Result.getExn->expect->toEqual(Foo))
  })

  describe("Bar", () => {
    let j = Bar->t_encode
    test("encodes", () => j->Js.Json.classify->expect->toEqual(2.0->Js.Json.JSONNumber))
    test("decodes", () => j->t_decode->Belt.Result.getExn->expect->toEqual(Bar))
  })
})
