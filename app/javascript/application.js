// Entry point for the build script in your package.json
import { Application } from "@hotwired/stimulus";
const application = Application.start();
window.Stimulus = application;

import moment from "moment";
import Raphael from "raphael";

import Rails from "@rails/ujs";

window.moment = moment;
window.Raphael = Raphael;
window.Rails = Rails;
Rails.start();

import "./ckeditor";
import "./controllers";
import "./add_jquery";
import select2 from 'select2';
select2();

import { ApplicationController } from "./controllers/application_controller";
import { ContentImageController } from "./controllers/content_image_controller";
import { FolderTreeController } from "./controllers/folder_tree_controller";
import { ContentTemplateController } from "./controllers/content_template_controller";
import { SideBarController } from "./controllers/side_bar_controller";
import { UserController } from "./controllers/user_controller";
import { ContentController } from "./controllers/content_controller";
import { CampaignController } from "./controllers/campaign_controller";

window.ApplicationController = ApplicationController;
window.ContentImageController = ContentImageController;
window.ContentTemplateController = ContentTemplateController;
window.FolderTreeController = FolderTreeController;
window.SideBarController = SideBarController;
window.UserController = UserController;
window.ContentController = ContentController;
window.CampaignController = CampaignController;
