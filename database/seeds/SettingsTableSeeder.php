<?php

use Illuminate\Database\Seeder;
use App\Models\Setting;

class SettingsTableSeeder extends Seeder
{
   /**
    * Run the database seeds.
    *
    * @return void
    */
   public function run()
   {
      Setting::create([
        'name' => 'Admin Panel',
        'slogan' => 'Admin Panel',
        'reg' => '12345',
        'stablished' => '1965',
        'email' => 'info@admin.com',
        'contact' => '01851334237',
        'address' => 'Chittagong',
        'website' => 'http://www.w3xplorers.com',
        'logo' => 'assets/images/logo/default.png',
        'layout' => '1',
        'running_year' => '2019',
        'created_at' => date('Y-m-d'),
        'updated_at' => date('Y-m-d')
      ]);
   }
}
