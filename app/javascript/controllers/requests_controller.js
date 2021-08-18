import { Controller } from "stimulus"
import Rails from "@rails/ujs";

export default class extends Controller {
  static target = ['output']
  
  static values = {
    url: String
  }

  connect() {
    console.log(this.urlValue)
    Rails.ajax({
      type: "get",
      url: this.urlValue
    })
  }
}
// Every partial that is prepended to hotwire frame triggers
// ajax to service_request#add_buttons with service_request_id