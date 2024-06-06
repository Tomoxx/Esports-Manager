<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class PlayersSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        DB::table('players')->insert([
            ['name' => 'pan', 'team_id' => '1'],
            ['name' => 'CAIOTG1', 'team_id' => '1'],
            ['name' => 'Royales', 'team_id' => '1'],
            ['name' => 'PJ', 'team_id' => '2'],
            ['name' => 'Luk', 'team_id' => '2'],
            ['name' => 'Davitrox', 'team_id' => '2'],
        ]);
    }
}
