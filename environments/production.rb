name "production"
description "For Prods!"
cookbook "apache", "= 0.1.2"
override_attributes({
	"pci" => {
	"in_scope" => false
	}
})