<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class TeamRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, \Illuminate\Contracts\Validation\ValidationRule|array<mixed>|string>
     */
    public function rules()
    {
        return [
            'name' => ['required', 'min:2'],
            'game' => ['required', 'min:2'],
            'region' => ['required', 'min:2'],
        ];
    }

    public function messages()
    {
        return [
            'name.required' => 'The team name field is required.',
            'name.min' => 'The team name must be at least 2 characters.',
            'game.required' => 'The game field is required.',
            'game.min' => 'The game must be at least 2 characters.',
            'region.required' => 'The region field is required.',
            'region.min' => 'The region must be at least 2 characters.',
        ];
    }
}
