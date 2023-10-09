// package main: Declares the package name.
// The main package is special in Go, it's where the execution of the program starts.
package main

// fmt is short for format, it contains functions that format the input and output.
import (
	//"log"
	"fmt"
	"github.com/google/uuid"
	"github.com/hashicorp/terraform-plugin-sdk/v2/diag"
	"github.com/hashicorp/terraform-plugin-sdk/v2/helper/schema"
	"github.com/hashicorp/terraform-plugin-sdk/v2/plugin"
)

// func main(): Defines the main function, the entry point of the application.
// When you run the program, it starts executing from this function
func main() {
	plugin.Serve(&plugin.ServeOpts{
		ProviderFunc: Provider,
	})
	// Format.PrintLine
	// Prints to standard output.
	fmt.Println("Hello, World!")
}

type Config struct {
	Endpoint string
	Token string
	UserUuid string
}

// in golang, a titlecase function will get exported
func Provider() *schema.Provider {
	var p *schema.Provider
	p = &schema.Provider{
		ResourcesMap: map[string]*schema.Resource{
			"terratowns_home": Resource(),
		},
		DataSourcesMap: map[string]*schema.Resource{

		},
		Schema: map[string]*schema.Schema{
			"endpoint": {
				Type: schema.TypeString,
				Required: true,
				Description: "The endpoint for the external service",
			},
			"token":{
				Type: schema.TypeString,
				Sensitive: true,  // make the token sensitive so that it is hid in the logs
				Required: true,
				Description: "Bearer token for authorization",
			},
			"user_uuid": {
				Type: schema.TypeString,
				Required: true,
				Description: "UUID for configuration",
				//ValidateFunc: validateUUID,
			},
		},
	}
	p.ConfigureContextFunc = providerConfigure(p)
	return p
}

//func validateUUID(v.interface{}, k string) (ws []string, errors []error) {
//	log.Print('validateUUID:start')
//	value := v.(string)
//	if _,err = uuid.Parse(value); err != nil {
//		errors = append(error, fmt.Errorf("invalide UUID format"))
//	}
//	log.Print('validateUUID:end')
//}