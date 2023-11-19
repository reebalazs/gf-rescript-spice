# Greenfinity utilities for the Spice PPX

## Scope

Spice PPX is a Rescript utility for defining data serializers and deserializers.

This package contains miscellaneous codecs and utilities for `ppx-spice`.

## Contents

### Codecs

### VariantFromDeriving

Solves the problem of serializing a variant as an integer. (This is not currently supported by spice.)

Usage in a single step:

```res
@deriving(jsConverter)
type t = | @as(0) Decimal

let (t_encode, t_decode) = GreenfinitySpice.Codecs.variantFromDeriving(
  ~toJs=tToJs,
  ~fromJs=tFromJs,
)
```

Or with two steps:

```
@deriving(jsConverter)
type t0 = | @as(0) Decimal

type t1 = @spice.codec(GreenfinitySpice.Codecs.variantFromDeriving(
  ~toJs=tToJs,
  ~fromJs=tFromJs,
)) t0
```

Consuming:

```res
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
```

### Int64AsString

The default payload for int64 is `bits_of_float`. This is more economical in terms of payload size, however often it is more benefitial to encode int64-s as strings. (For example debugging network traffic, or storing in a database.)

Also notably, the Caml library does not handle negative int64-s correctly, so if the application uses negative int64-s, the serialization will be broken.

Usage:

```res
@spice
type xInt64 = @spice.codec(GreenfinitySpice.Codecs.int64AsString) int64
// let (xInt64_encode, xInt64_decode) = int64Codec
```

Consuming:

```res
@spice
type t = {
  // Via helper type:
  id: xInt64,
  // OR directly:
  company_id: @spice.codec(GreenfinitySpice.Codecs.int64AsString) int64,
}
```
