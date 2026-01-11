use base32::Alphabet;
use extendr_api::{error::Result, prelude::*};

#[extendr]
fn encode_(x: Robj, alphabet: Option<&str>, padded: Option<bool>) -> Result<Strings> {
    let alphabet = get_alphabet(alphabet, padded);
    let ty = x.rtype();
    match ty {
        Rtype::Null => Ok(Strings::from_values(vec![Rstr::na()])),
        Rtype::Rstr => Rstr::try_from(x)
            .map(|xi| Strings::from_values([base32::encode(alphabet, xi.as_bytes())])),
        Rtype::Strings => Strings::try_from(x).map(|xi| {
            xi.into_iter()
                .map(|xii| base32::encode(alphabet, xii.as_bytes()))
                .collect::<Strings>()
        }),
        Rtype::Raw => Raw::try_from(x)
            .map(|xi| Strings::from_values([base32::encode(alphabet, xi.as_slice())])),
        _ => throw_r_error(format!("Cannot base32 encode type {ty:?}")),
    }
}

#[extendr]
fn decode_(x: Strings, alphabet: Option<&str>, padded: Option<bool>) -> List {
    let alphabet = get_alphabet(alphabet, padded);

    let mut res = x
        .into_iter()
        .map(|xi| match base32::decode(alphabet, xi) {
            Some(bytes) => Raw::from_bytes(&bytes),
            None => Raw::new(0),
        })
        .collect::<List>();

    let _ = res.set_class(["blob", "vctrs_list_of", "vctrs_vctr", "list"]);
    res
}

fn get_alphabet(alphabet: Option<&str>, padded: Option<bool>) -> Alphabet {
    let padded = padded.unwrap_or(true);

    match alphabet {
        Some(alphabet) => match alphabet.to_lowercase().as_str() {
            "crockford" => Alphabet::Crockford,
            "rfc4648" => Alphabet::Rfc4648 { padding: padded },
            "rfc4648lower" => Alphabet::Rfc4648Lower { padding: padded },
            "rfc4648hex" => Alphabet::Rfc4648Hex { padding: padded },
            "rfc4648hexlower" => Alphabet::Rfc4648HexLower { padding: padded },
            "z" => Alphabet::Z,
            _ => throw_r_error("Invalid alphabet name supplied"),
        },
        None => Alphabet::Crockford,
    }
}

extendr_module! {
    mod b32;
    fn encode_;
    fn decode_;
}
