<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class VenueRequest extends FormRequest
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
            'city' => ['required', 'min:2'],
        ];
    }

    // public function messages()
    // {
    //     return [
    //         'name.required' => 'The venue name field is required.',
    //         'name.min' => 'The venue name must be at least 2 characters.',
    //         'city.required' => 'The city field is required for the venue.',
    //         'city.min' => 'The city must be at least 2 characters.',
    //     ];
    // }
}
